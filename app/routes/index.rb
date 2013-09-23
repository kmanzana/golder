module Sinatra
  module GolderApp
    module Routing
      module Index
        def self.registered(app)
          index = lambda do
            slim :index,
              locals: {
                title: settings.title
              }
          end

          app.get '/', &index
        end
      end
    end
  end
end
