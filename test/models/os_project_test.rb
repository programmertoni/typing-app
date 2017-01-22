require 'test_helper'

class OsProjectTest < ActiveSupport::TestCase
  test "name cannot be blank" do
    os_project = OsProject.new(name: "")
    assert_not os_project.valid?
  end

  test "can have many os_pages" do
    language   = Language.create(name: "JavaScript")
    os_project = OsProject.create(name: "Angular")
    os_page_1  = OsPage.create(content: "Some long code")
    os_page_2  = OsPage.create(content: "def my method")
    language.os_projects << os_project
    os_project.os_pages  << os_page_1
    os_project.os_pages  << os_page_2

    javascript = Language.find_by(name: "JavaScript")
    angular    = OsProject.find_by(name: "Angular")

    assert_equal 2, angular.os_pages.count
  end

  test "page belongs to project and it belongs to language" do
    language   = Language.create(name: "JavaScript")
    os_project = OsProject.create(name: "Angular")
    os_page_1  = OsPage.create(content: "Some long code")
    os_page_2  = OsPage.create(content: "def my method")
    language.os_projects << os_project
    os_project.os_pages  << os_page_1
    os_project.os_pages  << os_page_2

    page = OsPage.find_by(content: "Some long code")
    assert_not_nil page&.os_project&.language
  end
end
