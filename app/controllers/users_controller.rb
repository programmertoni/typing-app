class UsersController < ApplicationController
  layout false

  def login; end

  def logout
    cookies.delete(:user_id)
    redirect_to root_path
  end

  def user_authenticate
    @user = User.first

    if @user.name === (params[:name]) && @user.password == params[:password]
      cookies.signed[:user_id] = {
        value: @user.id,
        expires: 1.year.from_now
      }
      redirect_to admin_languages_path
    else
      redirect_to root_path
    end

  end
end



