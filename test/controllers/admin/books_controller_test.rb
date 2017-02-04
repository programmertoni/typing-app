require 'test_helper'

class Admin::BooksControllerTest < ActionDispatch::IntegrationTest

  test "#index" do
    admin_signs_in
    get admin_books_url
    assert_response :success
  end

end
