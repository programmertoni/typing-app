class Admin::BooksController < AdminController

  def index
    @books = Book.all
    @book  = Book.new
  end

  def show
    @book      = Book.find(params[:id])
    @book_page = @book.book_pages.new
  end

  def create
    @book = Book.new(book_params)
    @book.save
    redirect_to admin_books_path
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to admin_books_path
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to admin_books_path
  end

  private

  def book_params
    params.require(:book).permit(:name)
  end
end
