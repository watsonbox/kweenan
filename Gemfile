source 'http://rubygems.org'

gem "rake", "0.8.7"
gem 'rails', '3.1.0.rc1'
gem 'mysql'
gem 'sass'
gem 'haml'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
gem 'devise'
gem 'high_voltage'
gem 'formtastic'
gem 'postmark-rails'
gem 'dynamic_form'

group :development, :test do
  gem "rspec-rails", "~> 2.6.1"
  gem "ruby-debug19"
end

group :development do
  gem 'heroku'
  gem 'mongrel', '1.2.0.pre2'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :production do
  gem 'therubyracer-heroku', '0.8.1.pre3'
  gem 'pg'
end