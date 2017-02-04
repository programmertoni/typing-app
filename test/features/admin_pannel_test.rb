require "test_helper"

class AdminPannelTest < Capybara::Rails::TestCase
  test "Admin logs in with right credentials and clicks through admin pannel" do
    login('admin', 'strong-password')

    assert_content page, "All Languages"
    fill_in 'language_name', with: 'JavaScript'
    click_button 'Add new language'

    assert_content page, 'JavaScript'

    click_link 'Edit'
    fill_in 'language_name', with: 'C++'
    click_button 'Edit language'
    assert_content page, 'C++'

    click_link 'C++'
    assert_content page, 'Open Source Project'
    fill_in 'os_project_name', with: 'typing app'
    click_button 'Add new open source project'
    assert_content page, 'typing app'

    click_link 'Edit'
    fill_in 'os_project_name', with: 'different typing app'
    click_button 'Edit Open Source Project'
    assert_content page, 'different typing app'

    click_link 'different typing app'
    click_link 'Add new Page'
    fill_in 'os_page_content', with: 'def method_name'
    click_button 'Add new Page'
    assert_content page, 'page 1'

    click_link 'page 1'
    assert_content page, 'def method_name'
    fill_in 'os_page_content', with: 'def some_other_method'
    click_button 'Update this page'
    assert_content page, 'page 1'

    click_link 'Delete'
    refute_content page, 'page 1'

    click_link 'Languages'
    assert_content page, 'C++'
    click_link 'Delete'
    refute_content page, 'C++'
    # end of testing Languages/OpenSourceProjects

  
    click_link 'Books'
    assert_content page, 'All Books'
    fill_in 'book_name', with: 'Star Trek'
    click_button 'Add new Book'
    assert_content page, 'Star Trek'
    click_link 'Edit'
    fill_in 'book_name', with: 'Star Wars'
    click_button 'Edit Book'
    assert_content 'Star Wars'
    
    click_link 'Star Wars'
    click_link 'Add new Page'
    fill_in 'book_page_content', with: 'in galaxi far far away'
    click_button 'Add new Page'
    assert_content page, 'page 1'
    click_link 'page 1'
    fill_in 'book_page_content', with: 'troopers'
    click_button 'Update this page'
    click_link 'page 1'
    assert_content page, 'troopers'
    click_button 'Update this page'
    click_link 'Delete'
    refute_content page, 'troopers'

    click_link 'Books'
    assert_content page, 'Star Wars'
    click_link 'Delete'
    refute_content page, 'Star Wars'

    # admin logs out
    visit logout_path

    # wrong credentials 
    login('Joe', 'strong-password')
    assert_content page, 'Hi!'
    login('admin', 'wrong_password')
    assert_content page, 'Hi!'
    login('Joe', 'wrong_password')
    assert_content page, 'Hi!'

    # other admin paths are locked out
    visit logout_path
    visit admin_books_path
    assert_content page, 'Hi!'
    visit admin_languages_path
    assert_content page, 'Hi!'
  end

  private

  def login(name, password)
    visit login_path
    assert_content page, "User name:"
    assert_content page, "Password:"

    fill_in 'name',     with: name
    fill_in 'password', with: password
    click_button 'Login'
  end
end
