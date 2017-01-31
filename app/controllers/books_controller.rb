class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @books         = Book.all
    @book          = Book.find(params[:id])

    @book_id  = @book.id
    @page_ids = @book.book_pages.order(:number).map(&:id)
  end

end
