# rubocop:disable Void
require 'spec_helper'
require 'tempfile'

describe 'files' do
  describe 'post /upload' do
    before do
      BWON.stub(:new).and_return(BWON)
    end

    it 'should do stuff' do
      post '/upload', file: { filename: 'example.csv', tempfile: 'foo' }
      last_response.should be_ok
      last_response.content_type.should == 'application/octet-stream'
    end

    context 'when no file is chosen' do
      it 'should redirect to index' do
        post '/upload'

        last_response.status.should == 302
        last_response.should be_redirect
        follow_redirect!
        last_request.url.should == 'http://example.org/'
      end
    end
  end
end
