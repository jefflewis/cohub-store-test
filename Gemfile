source 'https://rubygems.org'

gem 'rails', '~> 4'
gem 'pg'
gem 'sass'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder'

gem 'paperclip'
gem 'aws-sdk'

gem 'bower-rails'
gem 'angular-rails-templates'

gem "foreman"
group :production, :staging do
  gem "rails_12factor"
  gem "rails_stdout_logging"
  gem "rails_serve_static_assets"
end

group :test, :development do
  gem "rspec"
  gem "rspec-rails"
  gem "factory_girl_rails", "~> 4.0"
  gem "capybara"
  gem "database_cleaner"
  gem "selenium-webdriver"
  gem 'teaspoon-jasmine'
  gem 'phantomjs'
end

group :doc do
  gem 'sdoc', require: false
end
