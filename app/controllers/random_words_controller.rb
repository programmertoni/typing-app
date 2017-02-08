class RandomWordsController < ApplicationController

  def show
    @books     = Book.all
    @page_name = params[:page_name]
  end

  def generate_sentance
    current_page = params[:page_name]

    generated_text = case current_page
                     when "random: sentance"     then LiterateRandomizer.paragraph
                     when "random: chuck norris" then Faker::ChuckNorris.fact
                     when "random: hacker"       # https://github.com/stympy/faker/blob/master/doc/hacker.md
                     when "random: hipster"      # Faker::Hipster.paragraph
                     when "random: ancients"     # https://github.com/stympy/faker/blob/master/doc/ancient.md
                     when "random: Date"         # https://github.com/stympy/faker/blob/master/doc/date.md
                     when "random: name"         # Faker::Name.name                                           # => "Tyshawn Johns Sr."
                     when "random: address"      # Faker::Address.street_address                              # => "282 Kevin Brook" Faker::Address.street_name              # => "Larkin Fork"
                     when "random: city"         # Faker::Address.city                                        # => "Imogeneborough"
                     when "random: country"      # Faker::Address.country                                     # => "French Guiana"
                     when "random: space"        # https://github.com/stympy/faker/blob/master/doc/space.md
                     when "random: superhero"    # Faker::Superhero.name                                      # => "Magnificent Shatterstar"
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

end
