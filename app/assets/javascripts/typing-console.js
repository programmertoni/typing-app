function typingConsole(text){

  // var text = `
  // def define_model_callbacks(*callbacks)
  //   options = callbacks.extract_options!
  //   options = {
  //
  //     terminator: deprecated_false_terminator,
  //     skip_after_callbacks_if_terminated: true,
  //     scope: [:kind, :name],
  //     only: [:before, :around, :after]
  //   }.merge!(options)`;
  // var text = "after disaster can we be resurrected. It\'s only after you\'ve lost everything that you\'re free to do anything. Nothing is static, everything is evolving, everything is falling apart."
  // var text = `tonko`;
  var charPointer           = 0;
  var errors                = 0;
  var charIndex             = 0;
  var textLength            = text.length;
  var textInSpanWithIds     = "";
  var chars                 = text.split("");
  var defaultWordPerMinute  = 50;
  var computerWordPerMinute = localStorage.userWPM || defaultWordPerMinute;
  var toCharacter           = 5;

  var computerTimeout = function(wordPerMinute) {
    let secondsInMinute      = 60;
    let millisecundsInSecond = 1000;
    return secondsInMinute * millisecundsInSecond / wordPerMinute;
  }

  var computerDelayTime     = computerTimeout(computerWordPerMinute * toCharacter);

  // this is parsing text and giving it spans
  for(let i=0; i<textLength; i++) {
    if (text[i] == "\n") {
      textInSpanWithIds += text[i]
    }else if (((text[i] === " ") && (text[i-1] === " ")) || ((text[i] === " ") && (text[i-1] == "\n"))) {
      textInSpanWithIds += text[i]
    } else {
      textInSpanWithIds += `<span id="char-${charIndex}">${text[i]}</span>`;
      charIndex++;
    }
  }

  var lastSpanIndex = charIndex;

  document.getElementById("text").innerHTML = textInSpanWithIds;
  document.getElementById("char-0").className += "cursor";

  var computerBackgroundHighlighter = function(currentIndex) {
    if(currentIndex < lastSpanIndex) {
      document.getElementById(`char-${currentIndex}`).className += ' computer';
      currentIndex++;

      window.setTimeout(function(){
        computerBackgroundHighlighter(currentIndex);
      }, computerDelayTime);
    }
  }

  var Timer = {};

  var checkOnKeypress = function() {
    // execute computerBackgroundHighlighter only when first key is pressed
    if (charPointer === 0) {
      Timer.startTimer = new Date().getTime();

      if (compete) {
        computerBackgroundHighlighter(0);
      }
    }

    if (charPointer < lastSpanIndex) {
      var userKeyCode      = event.which;
      var userChar         = String.fromCharCode(userKeyCode);
      var currentCharacter = document.getElementById(`char-${charPointer}`).innerHTML;

      if(event.type === 'keydown') {
        if(!((userChar === ' ') && (currentCharacter === ' '))) {
          //continue with keydown event if user presses space
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
      Timer.endTimer         = new Date().getTime();
      let timeToFinishTyping = (Timer.endTimer - Timer.startTimer) / 1000;
      let numOfChar          = lastSpanIndex;
      let minute             = 60;
      let charsPerMinute     = (numOfChar * 60) / timeToFinishTyping;
      let wordsPerMinute     = Math.round(charsPerMinute / toCharacter);

      localStorage.setItem("userWPM", wordsPerMinute);

      document.getElementById("stats").innerHTML = `You typed ${(lastSpanIndex)-errors} characters correctly and typed ${errors} characters incorectly!  <br>Your speed: ${wordsPerMinute} words per minute! <br>Computer speed: ${computerWordPerMinute}`;
    } else if ((charPointer+1) >= lastSpanIndex) {
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
