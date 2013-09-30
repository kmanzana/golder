# recipes.sinatrarb.com
# http://www.sinatrarb.com/intro.html#Configuration
# security: http://stackoverflow.com/questions/8144186/what-are-the-best-practices-to-secure-a-sinatra-application

require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'sinatra/config_file'
require 'sinatra/flash'

require './app/helpers'
require './app/routes/views'
require './app/routes/files' # may need to load these instead of require http://sinatra.restafari.org/book.html#splitting_into_multiple_files

config_file 'config/golder_app.yml'

configure do
  set :root, File.dirname(__FILE__)

  Compass.add_project_configuration(File.join(settings.root, 'config', 'compass.rb'))
  Compass.configuration { |cfg| cfg.project_path = settings.root }

  set :slim, format: :html5
  set :sass, Compass.sass_engine_options

  set :session_secret, 'My session secret' # to fix shotgun reloading clearing session
  enable :sessions
end

configure :production do
  Compass.configuration do |config|
    config.output_style = :compressed
  end

  set :slim, {ugly: true}
  set :clean_trace, true
  # set :css_files, :blob
  # set :js_files,  :blob
  # MinifyResources.minify_all
end

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = settings.root

  set :slim, pretty: true
end

register Sinatra::Flash

helpers Helpers
register ViewRoutes
# register FileRoutes
