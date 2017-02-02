class AdminController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!

  def authenticate_user!
    redirect_to root_path unless cookies.signed[:user_id] == User.first.id
  end

end
