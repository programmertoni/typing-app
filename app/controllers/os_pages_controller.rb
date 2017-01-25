class OsPagesController < ApplicationController

  def show
    @languages  = Language.all
    @language   = Language.find(params[:language_id])
    @os_project = OsProject.find(params[:os_project_id])
    @page    = OsPage.find(params[:id])
  end

end
