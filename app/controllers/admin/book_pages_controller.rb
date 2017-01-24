class Admin::BookPagesController < ApplicationController
  layout 'admin'

  def new
    @book = Book.find(params[:book_id])
    @book_page = @book.book_pages.new
    @page_number = @book.book_pages.count.zero? ? 1 : @book.book_pages.count
  end

  def create
    @book = Book.find(params[:book_id])
    @book_page = @book.book_pages.create(book_pages_param)
    redirect_to admin_book_path(@book)
  end

  private

  def book_pages_param
    params.require(:book_page).permit(:number, :content, :book_id)
  end

end
