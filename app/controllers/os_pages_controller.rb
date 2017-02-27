class OsPagesController < ApplicationController

  def show
    @page = OsPage.find(params[:id])

    respond_to do |format|
      format.json { render json: { page_content: @page.content }} 
    end
  end

end
