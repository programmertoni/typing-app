class LanguagesController < ApplicationController

  def index
    @languages = Language.all
    @language  = Language.new
  end

end
