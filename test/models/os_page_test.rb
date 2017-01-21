require 'test_helper'

class OsPageTest < ActiveSupport::TestCase
  test "content cannot be blank" do
    page = OsPage.new(content: "")
    assert !page.valid?
  end
end
