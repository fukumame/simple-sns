require 'test_helper'

class BaseTest < ActionDispatch::IntegrationTest

  sub_test_case 'sub' do

    test 'main' do
      u = create(:user)
      visit 'http://localhost:3000/'
    end
  end


end