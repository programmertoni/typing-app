class Admin::LanguagesController < AdminController

  def index
    @languages = Language.all.order(:order)
    @language  = Language.new
  end

  def create
    Language.create(language_params)
    redirect_to admin_languages_path
  end

  def edit
    @language = Language.find(params[:id])
  end

  def update
    @language = Language.find(params[:id])
    @language.update(language_params)
    redirect_to admin_languages_path
  end

  def destroy
    language = Language.find(params[:id])
    language.destroy
    redirect_to admin_languages_path
  end

  private

  def language_params
    params.require(:language).permit(:order, :name)
  end
end
