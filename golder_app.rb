# recipes.sinatrarb.com
# http://www.sinatrarb.com/intro.html#Configuration
# security: http://stackoverflow.com/questions/8144186/what-are-the-best-practices-to-secure-a-sinatra-application # rubocop:disable LineLength

require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'sinatra/flash'
require './app/helpers'
require './app/routes/init' # may need to load these instead of require http://sinatra.restafari.org/book.html#splitting_into_multiple_files # rubocop:disable LineLength

configure do
  config_file 'config/all.yml'
  config_file 'config/envs.yml'
  set :root, File.dirname(__FILE__)
end

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = settings.root
end

register FileRoutes

get '/' do
  slim :index,
       locals: {
         title: settings.title
       }
end

not_found do
  halt 404, 'page not found'
end
