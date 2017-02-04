require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "can login" do
    admin_signs_in
    get admin_books_path
    assert_response :success
  end

end
