ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'test/unit/rails/test_help'
Dir[Rails.root.join("test/support/**/*.rb")].each {|f| require f }

require "factory_girl"
FactoryGirl.find_definitions

require "capybara/poltergeist"
Capybara.javascript_driver = :poltergeist

class ActiveSupport::TestCase
  # # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # self.use_transactional_tests = false
  # # Add more helper methods to be used by all tests here...
  include CapybaraConfig
  include DatabaseCleanerConfig
  include FactoryGirlConfig
  include GroongaHelper
  include HelperMethods
end
