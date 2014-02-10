source 'https://rubygems.org'
ruby '2.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use sqlite3 as the database for Active Record in development mode
group :development do
  gem 'sqlite3', '>= 1.3.8'
end

group :test do
  gem 'shoulda'
  gem 'mocha'
  gem 'capybara'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'simplecov'
end

# Use postgresql as the databse for Active Record in production mode
group :production do
  gem 'pg', '>= 0.17.0'

  # Deployment to Heroku:
  gem 'rails_12factor' # Improves static files serving.
  gem 'unicorn'        # Multi-processed web server, for better scalabity than with Webrick.
end


gem "recaptcha", "~> 0.3.6"

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '>= 3.1.0'    # Provides jQuery 1.10.2, the jQuery UJS adapter, and assert_select_jquery to test jQuery responses in Ruby tests.
gem 'jquery-ui-rails', '>= 4.1.1' # Provides jQuery UI 1.10.0 assets (JavaScripts, stylesheets, and images)

# Use Twitter Bootstrap as additional JavaScript library
# gem 'bootstrap-sass', '>=3.1.0.2' # Collapse plugin breaks layout in 3.1.0
gem 'bootstrap-sass', '3.0.3.0 '

# Use momentJS as additional JavaScript library -- for time, date, datetime, etc.
gem 'momentjs-rails', '>= 2.5.1'
gem 'bootstrap3-datetimepicker-rails', '>= 2.1.30'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'http_accept_language', '>= 2.0.1'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
