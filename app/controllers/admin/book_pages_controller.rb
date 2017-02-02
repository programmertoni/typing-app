class Admin::BookPagesController < AdminController

  def index
    @book = Book.find(params[:book_id])
    @book_pages = @book.book_pages.order(:number)
  end

  def new
    @book        = Book.find(params[:book_id])
    @book_page   = @book.book_pages.new
    @page_number = @book.book_pages.count.zero? ? 1 : (@book.book_pages.count + 1)
  end

  def create
    @book      = Book.find(params[:book_id])
    @book_page = @book.book_pages.create(book_pages_param)
    redirect_to admin_book_book_pages_path(@book)
  end

  def edit
    @book      = Book.find(params[:book_id])
    @book_page = BookPage.find(params[:id])
  end

  def update
    @book      = Book.find(params[:book_id])
    @book_page = @book.book_pages.find(params[:id]).update(book_pages_param)
    redirect_to admin_book_book_pages_url(@book)
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book.book_pages.find(params[:id]).destroy
    redirect_to admin_book_book_pages_url(@book)
  end

  private

  def book_pages_param
    params.require(:book_page).permit(:number, :content, :book_id)
  end

end
