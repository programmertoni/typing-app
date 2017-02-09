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
                     when "random: hacker"       then Faker::Hacker.say_something_smart
                     when "random: ancients"     then from_list_to_sentance "Faker::Ancient.god", "Faker::Ancient.primordial", "Faker::Ancient.titan", "Faker::Ancient.hero"
                     when "random: date"         then to_sentance "Faker::Date.between(100.years.ago, 100.years.from_now)", " "
                     when "random: space"        then from_list_to_sentance "Faker::Space.planet", "Faker::Space.moon", "Faker::Space.galaxy", "Faker::Space.nebula", "Faker::Space.star_cluster", "Faker::Space.constellation", "Faker::Space.star", "Faker::Space.agency", "Faker::Space.nasa_space_craft", "Faker::Space.company", "Faker::Space.meteorite"
                     when "random: food"         then from_list_to_sentance "Faker::Food.ingredient", "Faker::Food.spice"
                     when "random: names"        then to_sentance "Faker::Name.name"
                     when "random: addresses"    then to_sentance "Faker::Address.street_address"
                     when "random: cities"       then to_sentance "Faker::Address.city"
                     when "random: countries"    then to_sentance "Faker::Address.country"
                     when "random: superhero"    then to_sentance "Faker::Superhero.name"
                     when "random: email"        then to_sentance "Faker::Internet.email"
                     when "random: numbers"      then to_sentance "Faker::Number.number(10)", " "
                     when "random: websites"     then to_sentance "Faker::Internet.domain_name", " "
                     when "random: url"          then to_sentance "Faker::Internet.url"
                     when "random: characters"   then to_sentance "Faker::Internet.password(10, 20, true, true)", " "
                     when "radnom: [{()}]"
                     end

    respond_to do |format|
      format.json { render json: { page_content: generated_text }} 
    end
  end

  private

  def to_sentance(phrase, separator = ', ')
    result = []
    12.times { result << eval(phrase) }
    result.join(separator)
  end

  def from_list_to_sentance(*list)
    result = []
    list.cycle(5) { |x| result << eval(x) }
    result.join(', ')
  end
end
