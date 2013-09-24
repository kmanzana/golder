# recipes.sinatrarb.com
# http://www.sinatrarb.com/intro.html#Configuration
# security: http://stackoverflow.com/questions/8144186/what-are-the-best-practices-to-secure-a-sinatra-application
# padrino: http://www.padrinorb.com/

class GolderApp < Sinatra::Base
  configure do
    set :root, File.dirname(__FILE__)
    set :title, 'Vac Truck Movement Madness'

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
  end

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = settings.root

    set :slim, pretty: true
  end

  register Sinatra::Flash

  helpers Helpers
  register ViewRoutes
  register FileRoutes
end
