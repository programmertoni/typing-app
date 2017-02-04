ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  require 'minitest/reporters'
  Minitest::Reporters.use!

  require 'simplecov'
  SimpleCov.start 'rails' unless ENV['NO_COVERAGE']

  # Add more helper methods to be used by all tests here...
  def admin_signs_in
    post authenticate_user_path, params: { name: "admin", password: "strong-password" }
  end
end
