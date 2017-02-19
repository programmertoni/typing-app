class RandomWordsController < ApplicationController

  def show
    @books     = Book.all
    @page_name = params[:page_name]
  end

  def generate_sentance
    current_page = params[:page_name]

    generated_text = case current_page
                     when "random: paragraph"    then LiterateRandomizer.paragraph
                     when "random: braces"       then random_braces
                     when "random: symbols"      then random_symbols
                     when "random: characters"   then to_sentance "Faker::Internet.password(10, 20, true, true)", " "
                     when "random: numbers"      then to_sentance "Faker::Number.number(10)", " "
                     when "random: chuck norris" then Faker::ChuckNorris.fact
                     when "random: hipster"      then Faker::Hipster.paragraph
                     when "random: hacker"       then Faker::Hacker.say_something_smart
                     when "random: url"          then to_sentance "Faker::Internet.url"
                     when "random: email"        then to_sentance "Faker::Internet.email", " "
                     when "random: space"        then from_list_to_sentance "Faker::Space.planet", "Faker::Space.moon", "Faker::Space.galaxy", "Faker::Space.nebula", "Faker::Space.star_cluster", "Faker::Space.constellation", "Faker::Space.star", "Faker::Space.agency", "Faker::Space.nasa_space_craft", "Faker::Space.company", "Faker::Space.meteorite"
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

  def random_braces
    braces = %w([ { ( ) } ])
    result = []
    20.times { result << braces.shuffle }
    result.join
  end

  def random_symbols
    symbols = %w([ { ( ) } ] ! @ # $ % ^ & * ` ~ ? _ - ; , / ' " \\ | :)
    result = []
    20.times { result << symbols.shuffle }
    result.join
  end
end
