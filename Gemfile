source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.1'

gem 'dotenv-rails', require: 'dotenv/rails-now'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '>= 3.12.4'
gem 'aws-sdk-s3', require: false
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'factory_bot_rails'
gem 'jbuilder', '~> 2.5'
# Use Json Web Token (JWT) for token based authentication
gem 'jwt'
gem 'pundit'
gem 'rswag-api'
gem 'rswag-ui'

# Reduces boot times through caching; required in config/boot.rb
# gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootsnap', '~> 1.4', '>= 1.4.8', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :test do
  gem 'pundit-matchers', '~> 1.6.0'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'ffaker'
  gem 'rspec-rails'
  gem 'rswag-specs'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
