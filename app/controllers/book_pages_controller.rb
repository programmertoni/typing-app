class BookPagesController < ApplicationController

  def show
    # http://localhost:3000/books/14/book_pages/30

    @book      = Book.find(params[:book_id])
    @book_page = @book.book_pages.order(:number).find(params[:id])

    respond_to do |format|
      format.json { render json: { page_content: @book_page.content }} 
    end
  end

end
