source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# database rails wrapper(s) ...
gem 'pg'

gem 'activerecord-import'
gem 'fastercsv'

# user management ...
gem 'devise'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# USe paperclip ...
gem "paperclip", "~> 6.0.0"

gem 'autoprefixer-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-validation-rails'
gem 'jquery-datetimepicker-rails', '~> 2.4', '>= 2.4.1.0'

gem 'bootstrap-sass'

gem 'cocoon'
gem 'simple_form'
gem 'chosen-rails'
gem 'aws-sdk', '~> 3'
gem 'kaminari'
gem 'ckeditor'
gem 'rmagick'

gem 'angular_rails_csrf'
gem 'omniauth'
gem 'omniauth-facebook', '~> 2.0.1'
gem 'fbgraph'
gem 'omniauth-google-oauth2'
gem 'google-id-token', github: 'Nerian/google-id-token'
gem 'geocoder'

gem 'activeadmin', github: 'activeadmin/activeadmin'
gem 'ffaker', github: 'emmanueloga/ffaker'
gem 'faraday'
gem 'cancancan'
#gem 'activeadmin_hstore_editor'
gem 'has_scope'

gem 'whenever', :require => false
gem 'delayed_job_active_record'
gem 'daemons'

gem 'capistrano-rails'
gem 'capistrano-rvm'
gem 'capistrano-passenger'

# gem 'bower-rails'

# gem for logistic regression ML model ...
gem 'liblinear-ruby'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  # gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  # gem 'chromedriver-helper'

  gem 'sdoc', '~> 0.4.0' # bundle exec rake doc:rails generates the API under doc/api.
  gem 'pry'
  gem 'pry-byebug'
  # gem 'spring'
  # gem 'capistrano-rails', group: :development
  gem 'rspec-rails'
  gem 'factory_bot'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false

  gem 'better_errors'
  gem 'binding_of_caller'

end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
