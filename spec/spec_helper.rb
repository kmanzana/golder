ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require_relative '../golder_app'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end
