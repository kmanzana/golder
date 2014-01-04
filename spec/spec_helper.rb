require 'spork'

ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'

Spork.prefork do
  require File.join(File.dirname(__FILE__), '..', 'golder_app.rb')
  require File.join(File.expand_path('.'), 'lib/tasks/rule_book_builder.rb')
  require File.join(File.expand_path('.'), 'lib/lookup_key_generator.rb')

  require 'sinatra'
  require 'rspec'
  require 'rack/test'
  require 'capybara'
  require 'capybara/dsl'

  Capybara.app = Sinatra::Application # in order to make Capybara work

  # set test environments
  set :environment, :test
  set :run, false
  set :raise_errors, true
  set :logging, false

  RSpec.configure do |conf|
    conf.include Rack::Test::Methods
    conf.include Capybara::DSL
  end

  def app
    @app ||= Sinatra::Application
  end
end

Spork.each_run do
end
