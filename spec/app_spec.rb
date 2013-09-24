require 'spec_helper'

describe 'App' do
  it 'main page' do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to include('madness')
  end

  describe 'post to uploads' do
    it 'should upload the file' do
      post '/uploads', { filename: 'example.csv' }
      
      expect(last_response).to be_ok
      expect(last_response.body).to eq('Uploading file: example.csv')
    end
  end
end
