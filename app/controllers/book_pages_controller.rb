class BookPagesController < ApplicationController
  def show
    @books           = Book.all
    @book            = Book.find(params[:book_id])
    @all_page_ids    = @book.book_pages.order(:number).map(&:id)
    current_page_num = params['page_counter'].to_i
    page_id          = @all_page_ids[current_page_num-1]
    @page            = BookPage.find(page_id)

    params['next_page']    = @all_page_ids[current_page_num]
    params['page_counter'] = current_page_num + 1
  end
end
