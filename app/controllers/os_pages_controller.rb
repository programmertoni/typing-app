class OsPagesController < ApplicationController

  def show
    # @languages  = Language.all
    # @language   = Language.find(params[:language_id])
    # @os_project = OsProject.find(params[:os_project_id])
    @page       = OsPage.find(params[:id])


    respond_to do |format|
      format.json { render json: { page_content: @page.content }} 
    end
  end

end
