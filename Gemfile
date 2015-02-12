source 'https://rubygems.org'

gem 'rails', '4.2.0'
gem 'rails-api'
gem 'pg'

gem 'sidekiq'
gem 'active_model_serializers', '~> 0.8.0', '>= 0.8.3'
gem 'yelp_html_parser'
gem 'yelp', require: 'yelp'

# Versioning APIs
gem 'versionist'

# Scheduling and worker
gem 'sinatra', '>= 1.3.0', require: false # required by Sidekiq::Web

group :development do
  gem 'seed-fu', "~> 2.3.0"
end

group :development, :test do
  gem 'byebug'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'database_cleaner', ">= 1.0.1"
  gem 'webmock', "~> 1.17.0"
  gem 'simplecov', "~> 0.8", require: false
  gem 'timecop'
end
