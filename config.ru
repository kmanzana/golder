ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'sinatra/flash'

require './app/helpers'
require './app/routes/views'
require './app/routes/files'

require File.dirname(__FILE__) + '/golder_app'
 
run GolderApp
