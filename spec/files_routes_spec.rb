require 'spec_helper'

describe 'Files Routes' do
  describe 'post /uploads' do
    post '/uploads', {
      file: {
      filename: 'example.csv',
      tempfile: 'blah'
    }}
  end
end
