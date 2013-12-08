module FileRoutes
  def self.registered(app)
    app.post '/upload', &self.upload

    app.get '/download/:filename' do |filename|
      f = File.open("newfile",  "r")
      # f.write("1234567890")     #=> 10
      puts f.read

      send_file f, filename: 'newfile.txt'

      f.close
      f.unlink
    end
  end

  def self.upload
    lambda do
      if params[:file]
        # filename = params[:file][:filename]
        # file = params[:file][:tempfile]

        # file.read

        flash[:success] = 'Upload successful'
      else
        flash[:warning] = 'You have to choose a file'
      end

      redirect '/'
    end
  end
end
