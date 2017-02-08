window.addEventListener('load', function () {
  var htmlData = $("#html-data");

  var typeConsole = new Vue({
    el: '#type-console',
    data: {
      pageParentName: htmlData.data('parent-name'),
      currentPage: htmlData.data('current-page'),
      resourceId: htmlData.data('id'),
      secondResourceId: htmlData.data('second-id'),
      pageIds: htmlData.data('page-ids'),
      pagesSize: htmlData.data('pages-size'),
      pageCounter: 0,
      currentPercentage: '0%',
      content: "",
      stats: false,
      accuracy: "",
      userSpeedMsq: "",
      computerSpeedMsg: "",
      finishExercise: false,
      compete: (localStorage.compete || '0'),
      userNotFinished: true,
      userFinished: ! this.userNotFinished
    },
    created: function(){
      if ((htmlData.data('id')) || (this.currentPage == 'random-words')) {
        this.fetchPageContent();
      }
    },
    computed: {
      computePagePercentage: function(){
        return this.currentPercentage = String(Math.round(this.pageCounter / this.pagesSize * 100)) + '%';
      }

    },
    methods: {
      competeToggle: function(){
        (this.compete == '0') ? this.compete = '1' : this.compete = '0'
          localStorage.setItem("compete", this.compete);
      },
      fetchPageContent: function(){
        if ((this.currentPage == 'random-words') || (this.pageIds.length > 0))  {
          var url;

          if (this.currentPage === 'book') {
            url = `/books/${this.resourceId}/book_pages/${this.pageIds.shift()}.json`;
          } else if (this.currentPage == 'random-words') {
            url = `/generate-random-words.json?page_name=${htmlData.data('parent-name')}`
          } else {
            url = `/languages/${this.resourceId}/os_projects/${this.secondResourceId}/os_pages/${this.pageIds.shift()}.json`;
          }

          this.$http.get(url).then((response) => {
            this.typingConsole(response.data.page_content);
          }, (response) => {
            alert("We had trouble loading content. Please reload the page.")
          });
        } else {
          this.finishExercise = true;
        }
      },
      typingConsole: function(text) {
        vm = this;
        var charPointer           = 0;
        var errors                = 0;
        var charIndex             = 0;
        var textLength            = text.length;
        var textInSpanWithIds     = "";
        var chars                 = text.split("");
        var defaultWordPerMinute  = 50;
        var computerWordPerMinute = localStorage.userWPM || defaultWordPerMinute;
        var toCharacter           = 5;
        var pageUrl               = window.location.href;
        var currentCharacter;

        var computerTimeout = function(wordPerMinute) {
          let secondsInMinute      = 60;
          let millisecundsInSecond = 1000;
          return secondsInMinute * millisecundsInSecond / wordPerMinute;
        }

        var computerDelayTime = computerTimeout(computerWordPerMinute * toCharacter);

        // this is parsing text and giving it spans
        for(let i=0; i<textLength; i++) {
          if ((text[i] === "\n") || text[i] === "\r") {
            textInSpanWithIds += text[i]
          }else if (((text[i] === " ") && (text[i-1] === " ")) || ((text[i] === " ") && (text[i-1] == "\n"))) {
            textInSpanWithIds += text[i]
          } else {
            textInSpanWithIds += `<span id="char-${charIndex}">${text[i]}</span>`;
            charIndex++;
          }
        }

        var lastSpanIndex = charIndex;
        var computerIndex = 0;
        var timeouts = [];

        document.getElementById("text").innerHTML = textInSpanWithIds;
        document.getElementById("char-0").className += "cursor";

        var computerBackgroundHighlighter = function(e) {
          timeouts.push(setTimeout(function(){
            if(computerIndex < lastSpanIndex && vm.userNotFinished) {

              if(e.type === 'keypress') {
                document.getElementById(`char-${computerIndex}`).className += ' computer';
                computerIndex++;
                computerBackgroundHighlighter(e);
              }
            }
          }, computerDelayTime))
        }

        var timer = {};

        var checkOnKeypress = function(event) {
          // execute computerBackgroundHighlighter only when first key is pressed
          if (charPointer === 0) {
            timer.startTimer = new Date().getTime();

            if (Number(vm.compete)) { computerBackgroundHighlighter(event) }
          }

          if (charPointer < lastSpanIndex) {
            let userKeyCode       = event.which;
            let userChar          = String.fromCharCode(userKeyCode);
            currentCharacter      = $(`#char-${charPointer}`).text();

            // handles chrome weird 'space' hijacking
            var previousChar = function(){ return charPointer ?  document.getElementById(`char-${charPointer-1}`).innerHTML : document.getElementById(`char-${charPointer}`).innerHTML; };
            let previousCharacter = previousChar();
            if (event.type == 'keypress') {
              if((userChar === ' ') && previousCharacter === ' ') { return }
            } else {
              if(!((userChar === ' ') && (currentCharacter === ' '))) {
                return;
              }
            }

            // removes currsor highlighter
            currentClasses = document.getElementById(`char-${charPointer}`).className;
            document.getElementById(`char-${charPointer}`).className = currentClasses.replace("cursor", "");

            // highlights correct/wrong user input
            if (userChar === currentCharacter) {
              document.getElementById(`char-${charPointer}`).className += " right-char";

            } else {
              let currentSpanCharacter = document.getElementById(`char-${charPointer}`);
              currentSpanCharacter.className += " wrong-char";

              if (currentSpanCharacter.innerHTML === " ") {
                currentSpanCharacter.innerHTML = "_";
              }
              errors++
            }
          }

          // calculate times and display stats
          if ((charPointer+1) === lastSpanIndex) {
            // clear (setTimeout) parallel highlighting from previous page
            vm.userNotFinished = false;
            for (var i = 0; i < timeouts.length; i++) {
              clearTimeout(timeouts[i]);
            }
            timeouts = [];

            timer.endTimer         = new Date().getTime();
            let timeToFinishTyping = (timer.endTimer - timer.startTimer) / 1000;
            let correctlyTypedChar = (lastSpanIndex) - errors;
            let minute             = 60;
            let charsPerMinute     = (correctlyTypedChar * 60) / timeToFinishTyping;
            let wordsPerMinute     = Math.round(charsPerMinute / toCharacter);
            let allCharacters      = lastSpanIndex;

            localStorage.setItem("userWPM", wordsPerMinute);

            // display stats
            vm.pageCounter += 1;
            vm.stats            = true;
            vm.accuracy         = `${Math.round(correctlyTypedChar * 100 / allCharacters)}%`
            vm.userSpeedMsq     = wordsPerMinute;
            vm.computerSpeedMsg = computerWordPerMinute;
          } else if ((charPointer) == lastSpanIndex) {
            vm.userNotFinished     = true;
            typeConsole.fetchPageContent();
            vm.stats = "";
          } else if ((charPointer+1) > lastSpanIndex) {
            return;
          }
          charPointer += 1;

          // adds currsor highlighter to next character
          if (charPointer < lastSpanIndex) {
            document.getElementById(`char-${charPointer}`).className += " cursor"
          }
        }

        document.body.addEventListener('keypress', checkOnKeypress);
        document.body.addEventListener('keydown', checkOnKeypress);
      }
    }
  })
})

