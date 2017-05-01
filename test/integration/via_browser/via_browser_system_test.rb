require 'test_helper'

class ViaBrowserSystemTest < ActionDispatch::IntegrationTest

  test 'main' do

    # login process
    visit new_user_session_path
    fill_in('user[email]', :with => 'test1@example.com')
    fill_in('user[password]', :with => 'zaq12wsx')
    find('input[name="commit"]').trigger('click')
    assert has_selector?('h2', text: "New Post")

    # new post process
    within 'form#new_post' do
      fill_in('post[content]', :with => 'post content1')
      find('input[name="commit"]').trigger('click')
    end

    within '#post-index' do
      visit root_path
      screenshot_and_save_page
      assert has_selector?('.feed-index__post-content', text: 'post content1')
    end

  end


end