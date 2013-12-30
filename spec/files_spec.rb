require 'spec_helper'

ROOT = 'http://example.org/'

describe 'file operations' do
  describe 'post /upload' do
    let(:tempfile) { Tempfile.new('foo') }

    before { BWONOutput.stub(:build) }

    after do
      tempfile.close
      tempfile.unlink
    end

    it 'should receive the file and start a download' do
      post '/upload',
           file: { filename: 'example.csv', tempfile: tempfile.path }

      last_response.should be_ok
      last_response.content_type.should == 'application/octet-stream'
    end

    context 'when no file is chosen' do
      it 'should redirect to root' do
        post '/upload'

        last_response.status.should == 302 # rubocop:disable Void
        last_response.should be_redirect
        follow_redirect!
        last_request.url.should == ROOT
      end
    end
  end

  describe 'get /upload' do
    it 'should redirect to root' do
      get '/upload'

      last_response.should be_redirect
      follow_redirect!
      last_request.url.should == ROOT
    end
  end
end
