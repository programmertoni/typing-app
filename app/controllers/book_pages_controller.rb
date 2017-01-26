class BookPagesController < ApplicationController
  def show
    @books = Book.all
    @book  = Book.find(params[:book_id])
    @page  = BookPage.find(params[:id])
  end
end
