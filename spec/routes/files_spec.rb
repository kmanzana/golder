require 'spec_helper'

describe 'Files Routes' do
  describe 'post /upload' do
    it 'should do stuff' do
      post '/upload', {
        file: {
        filename: 'example.csv',
        tempfile: 'foo,bar,qux'
      }}

      last_response.status.should == 302
      last_response.should be_redirect
      follow_redirect!
      last_request.url.should == 'http://example.org/'
    end
  end
end
