module CapybaraConfig
  require 'capybara/poltergeist'
  Capybara.default_driver = :poltergeist
  Capybara.ignore_hidden_elements = true
  Capybara.default_max_wait_time = 10

  # options = {
  #     phantomjs_options: ['--debug=no', '--load-images=no', '--ignore-ssl-errors=yes', '--ssl-protocol=any'],
  #     debug: false
  # }
  # Capybara.register_driver :poltergeist do |app|
  #   Capybara::Poltergeist::Driver.new(app, options)
  # end

  class ActionDispatch::IntegrationTest
    include Capybara::DSL
  end
end
