require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'sinatra/flash'
require './app/helpers'
require './lib/lookup_key_generator'
require './app/bwon_output'

configure do
  config_file 'config/all.yml'
  config_file 'config/envs.yml'
  set :root, File.dirname(__FILE__)
  set :views, proc { File.join(settings.root, 'app/views') }
end

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = settings.root
end

get '/' do
  slim :index,
       locals: {
         title: settings.title
       }
end

post '/upload' do
  if params[:file]
    filename = params[:file][:filename]
    file = params[:file][:tempfile]

    bwon = BWONOutput.new(file)

    content_type 'application/octet-stream'
    attachment bwon.download_filename(filename)
    bwon.build
  else
    flash[:warning] = 'You have to choose a file'
    redirect '/'
  end
end

get '/upload' do
  redirect '/'
end

not_found do
  halt 404, 'page not found'
end

error do
  'Sorry there was a nasty error - ' + env['sinatra.error'].name
end
