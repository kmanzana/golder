# recipes.sinatrarb.com
# http://blog.carbonfive.com/2013/06/24/sinatra-best-practices-part-one/
# http://sinatra-book.gittr.com/
# http://www.sinatrarb.com/intro.html#Configuration
# slim: http://rdoc.info/gems/slim
# testing: http://robots.thoughtbot.com/post/45581933187/how-to-test-sinatra-based-web-services
# security: http://stackoverflow.com/questions/8144186/what-are-the-best-practices-to-secure-a-sinatra-application
# padrino: http://www.padrinorb.com/

ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require './app/helpers'
require './app/routes/index'

class GolderApp < Sinatra::Base
  configure do
    set :root, File.dirname(__FILE__)
    set :title, 'Vac Truck Movement Madness'

    Compass.add_project_configuration(File.join(settings.root, 'config', 'compass.rb'))
    Compass.configuration { |cfg| cfg.project_path = settings.root }

    set :slim, format: :html5
    set :sass, Compass.sass_engine_options
  end

  configure :production do
    Compass.configuration do |config|
      config.output_style = :compressed
    end
  end

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = settings.root

    set :slim, pretty: true
  end

  helpers Sinatra::GolderApp::Helpers

  register Sinatra::GolderApp::Routing::Index

  post '/uploads' do  
    "Uploading file: #{params[:filename]}"
  end 

  not_found do  
    halt 404, 'page not found' 
  end 
end
