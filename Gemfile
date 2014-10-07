source 'https://rubygems.org'

ruby '2.0.0', patchlevel: '481'

gem 'sinatra'
gem 'slim'
gem 'sass'
gem 'compass'
gem 'bootstrap-sass'
gem 'sinatra-flash'
gem 'sinatra-contrib'

group :development do
  gem 'better_errors'
  # uncomment this for more advanced features:
  # gem 'binding_of_caller'

  gem 'shotgun'
  gem 'rake'
end

group :test do
  gem 'capybara'

  gem 'rb-fsevent', require: false
  gem 'growl'
end

group :development, :test do
  gem 'rspec'
  gem 'rack-test'

  gem 'guard-rspec', require: false
  gem 'guard-bundler'

  gem 'guard-spork'
  gem 'spork'
end
