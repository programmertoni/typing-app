class Admin::OsProjectsController < ApplicationController

  def index
    @language    = Language.find(params[:language_id])
    @os_projects = @language.os_projects.order(:order)
    @os_project  = OsProject.new
  end

  def create
    language = Language.find(params[:language_id])
    language.os_projects.create(os_project_params)
    redirect_to admin_language_os_projects_path(language)
  end

  def edit
    @language   = Language.find(params[:language_id])
    @os_project = OsProject.find(params[:id])
  end

  def update
    language   = Language.find(params[:language_id])
    os_project = OsProject.find(params[:id]).update(os_project_params)
    redirect_to admin_language_os_projects_path(language)
  end

  def destroy
    language   = Language.find(params[:language_id])
    os_project = OsProject.find(params[:id])
    os_project.destroy
    redirect_to admin_language_os_projects_path(language)
  end

  private

  def os_project_params
    params.require(:os_project).permit(:order, :name)
  end

end
