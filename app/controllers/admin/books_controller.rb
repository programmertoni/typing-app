class Admin::BooksController < AdminController

  def index
    @books = Book.all
  end

end
