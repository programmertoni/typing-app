require 'test_helper'

class BookPageTest < ActiveSupport::TestCase
  test "book_page has one book" do
    book      = Book.create!(name: "RoR Book")
    book_page = BookPage.create(number: 1, content: "lorem ipsum dorem")
    book.book_pages << book_page

    page = BookPage.find_by(number: 1)
    assert_not_nil page.book
  end
end
