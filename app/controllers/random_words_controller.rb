class RandomWordsController < ApplicationController

  def show
    @books     = Book.all
  end

  def generate_sentance
    random_words = %w(dadi tonko marjan alenka masa dejan denis erik matjaz)
    generated_text = random_words.shuffle.join(" ")

    respond_to do |format|
      format.json { render json: { page_content: generated_text }} 
    end
  end

end
