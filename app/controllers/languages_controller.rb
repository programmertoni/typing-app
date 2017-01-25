class LanguagesController < ApplicationController

  def index
    @languages = Language.all
    @books     = Book.all
  end

end
