require 'test_helper'

class BaseTest < ActionDispatch::IntegrationTest

  sub_test_case 'sub' do

    test 'main' do
      u = create(:user)
      assert_equal 'hoge@example.com', u.email
      visit 'http://localhost:3000/'
      assert has_selector?('h1', text: 'Yay! You’re on Rails!')
    end
  end


end