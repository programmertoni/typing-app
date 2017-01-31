class OsProjectsController < ApplicationController

  def index
    @os_projects = OsProject.all
  end


end
