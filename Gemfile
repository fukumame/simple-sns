source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby '2.3.1'

gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'gon'
gem 'haml-rails'
gem 'honoka-rails', '>= 3.3.6.3'
gem 'html2haml'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'pg', '~> 0.20.0'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.2'
gem 'rails-i18n', '~> 5.0.0' # For 5.0.x
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'


group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_girl'
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '2.11.0', require: false
  gem 'database_cleaner'
  gem 'poltergeist', '1.12.0',require: false
  gem "test-unit-rails", require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
