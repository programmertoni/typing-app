require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    User.destroy_all
    user          = User.new
    user.name     = "admin"
    user.password = "strong-password"
    user.save
  end

  test "can login" do
    admin_signs_in
    get admin_books_path
    assert_response :success
  end

  private

  def admin_signs_in
    post authenticate_user_path, params: { name: "admin", password: "strong-password" }
  end
end
