module ViewRoutes
  def self.registered(app)
    app.get '/', &@index
    app.not_found &@not_found
  end

  @not_found = lambda do
      halt 404, 'page not found' 
  end

  @index = lambda do
    # @title = settings.title
    slim :index,
      locals: {
        title: settings.title
      }
  end
end
