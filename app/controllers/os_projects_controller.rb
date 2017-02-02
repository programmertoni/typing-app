class OsProjectsController < ApplicationController
  def show
    @languages     = Language.all
    @language_id   = params[:language_id]
    @os_project    = OsProject.find(params[:id])
    @os_project_id = @os_project.id
    @page_ids      = @os_project.os_pages.map(&:id)
  end
end
