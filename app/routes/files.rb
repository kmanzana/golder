post '/upload' do
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
