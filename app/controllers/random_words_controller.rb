class RandomWordsController < ApplicationController

  def show
    @books     = Book.all
    @page_name = params[:page_name]
  end

  def generate_sentance
    current_page = params[:page_name]

    generated_text = case current_page
                     when "random: paragraph"    then LiterateRandomizer.paragraph
                     when "random: chuck norris" then Faker::ChuckNorris.fact
                     when "random: hipster"      then Faker::Hipster.paragraph
                     when "random: hacker"       # https://github.com/stympy/faker/blob/master/doc/hacker.md
                     when "random: ancients"     # https://github.com/stympy/faker/blob/master/doc/ancient.md
                     when "random: Date"         # https://github.com/stympy/faker/blob/master/doc/date.md

                     when "random: names"        then to_sentance "Faker::Name.name"
                     when "random: addresses"    then to_sentance "Faker::Address.street_address"
                     when "random: cities"       then to_sentance "Faker::Address.city"
                     when "random: countries"      then to_sentance "Faker::Address.country"
                     when "random: space"        # https://github.com/stympy/faker/blob/master/doc/space.md
                     when "random: superhero"    then to_sentance "Faker::Superhero.name"
                     when "random: email"        # Faker::Internet.email                                      # => "eliza@mann.net"
                     when "random: numbers"      # Faker::Number.number(10)                                   # => "1968353479"
                     when "random: websites"     # Faker::Internet.domain_name                                # => "effertz.info"
                     when "random: url"          # Faker::Internet.url                                        # => "http://thiel.com/chauncey_simonis"
                     when "random: characters"   # Faker::Internet.password(10, 20, true, true)               # => "*%NkOnJsH4"
                     when "random: food"         # https://github.com/stympy/faker/blob/master/doc/food.md
                     when "radnom: [{()}]"
                     end

    respond_to do |format|
      format.json { render json: { page_content: generated_text }} 
    end
  end

  private

  def to_sentance(phrase)
    arr = []
    10.times { arr << eval(phrase) }
    arr.join(", ")
  end

end
