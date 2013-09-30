ENV['RACK_ENV'] ||= 'development'

require File.dirname(__FILE__) + '/golder_app'
 
run Sinatra::Application
