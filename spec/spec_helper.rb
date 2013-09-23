ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require_relative '../app'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  def app
    GolderApp
  end
end
