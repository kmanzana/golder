# recipes.sinatrarb.com
# http://sinatra-book.gittr.com/
# http://www.sinatrarb.com/intro.html#Configuration
# slim: http://rdoc.info/gems/slim
# testing: http://robots.thoughtbot.com/post/45581933187/how-to-test-sinatra-based-web-services
# security: http://stackoverflow.com/questions/8144186/what-are-the-best-practices-to-secure-a-sinatra-application
# padrino: http://www.padrinorb.com/

require 'bundler/setup'
Bundler.require(:default, :test, :development)

configure do
  set :root, Sinatra::Application.root
  set :title, 'Vac Truck Movement Madness'

  Compass.add_project_configuration(File.join(settings.root, 'config', 'compass.rb'))

  Compass.configuration do |config|
    config.project_path = settings.root
  end

  set :slim, format: :html5
  set :sass, Compass.sass_engine_options
end

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = settings.root

  set :slim, pretty: true
end

get '/' do
  raise 'go to https://github.com/pokle/sinatra-bootstrap to get the boostrap'
end

get '/' do
  slim :index,
    locals: {
      title: settings.title
    }
end

post '/uploads' do  
  "Uploading file: #{params[:filename]}"
end 

not_found do  
  halt 404, 'page not found' 
end 
