module FileRoutes
  def self.registered(app)
    app.post '/upload' do
      if params[:file]
        filename = params[:file][:filename]
        file = params[:file][:tempfile]

        # File.open(File.join(settings.root, 'uploads', filename), 'wb') do |f|
        #   f.write file.read
        # end

        # flash 'Upload successful'
      # else
        # flash 'You have to choose a file'
      end

      redirect '/'
    end
  end
end
