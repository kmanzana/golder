module FileRoutes
  def self.registered(app)
    app.post '/upload', &self.upload

    app.get '/download/:filename' do |filename|
      send_file "./files/#{filename}", :filename => filename, :type => 'Application/octet-stream'
    end
  end

  def self.upload
    lambda do
      if params[:file]
        filename = params[:file][:filename]
        file = params[:file][:tempfile]

        # file.read

        flash[:success] = 'Upload successful'
      else
        flash[:warning] = 'You have to choose a file'
      end

      redirect '/'
    end
  end
end
