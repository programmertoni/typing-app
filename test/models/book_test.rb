require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test "name is not valid when is blank" do
    new_book = Book.new(name: "")
    assert_not new_book.valid?
  end

  test "book has many book_pages" do
    book      = Book.create!(name: "RoR Book")
    book_page = BookPage.create(number: 1, content: "lorem ipsum dorem")
    book.book_pages << book_page
    assert_equal 1, book.book_pages.count
  end
end
