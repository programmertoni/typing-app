class Admin::OsPagesController < AdminController

  def index
    @language   = Language.find(params[:language_id])
    @os_project = OsProject.find(params[:os_project_id])
    @os_pages   = @os_project.os_pages.order(:number)
  end

  def new
    @language    = Language.find(params[:language_id])
    @os_project  = OsProject.find(params[:os_project_id])
    @os_page     = OsPage.new
    pages_num    = @os_project.os_pages.count
    @page_number = pages_num.zero? ? 1 : (pages_num + 1)
  end

  def create
    language    = Language.find(params[:language_id])
    os_project  = OsProject.find(params[:os_project_id])
    os_project.os_pages.create(os_page_params)
    redirect_to admin_language_os_project_os_pages_path(language, os_project)
  end

  def edit
    @language   = Language.find(params[:language_id])
    @os_project = OsProject.find(params[:os_project_id])
    @os_page    = OsPage.find(params[:id])
  end

  def update
    language   = Language.find(params[:language_id])
    os_project = OsProject.find(params[:os_project_id])
    os_page    = OsPage.find(params[:id])
    os_page.update(os_page_params)
    redirect_to admin_language_os_project_os_pages_path(language, os_project)
  end

  def destroy
    language   = Language.find(params[:language_id])
    os_project = OsProject.find(params[:os_project_id])
    os_page    = OsPage.find(params[:id])
    os_page.destroy
    redirect_to admin_language_os_project_os_pages_path(language, os_project)
  end

  private

  def os_page_params
    params.require(:os_page).permit(:number, :content)
  end
end
