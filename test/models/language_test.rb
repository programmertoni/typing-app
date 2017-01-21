require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test "name cannot be blank" do
    language = Language.new(name: "")
    assert !language.valid?
  end

  test "language has many os_projects" do
    language   = Language.create(name: "JavaScript")
    os_project = OsProject.create(name: "Angular")

    assert_equal 0, language.os_projects.count
    language.os_projects << os_project
    assert_equal 1, language.os_projects.count
    java_script = Language.find_by(name: "JavaScript")
    assert_equal 1, java_script.os_projects.count
  end
end
