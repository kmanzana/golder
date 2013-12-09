# rubocop:disable Void
require 'spec_helper'

describe '' do
  describe 'post /upload' do
    before { BWONOutput.stub(:build) }
    after { tempfile.close; tempfile.unlink }

    let(:tempfile) { Tempfile.new('foo') }

    it 'should receive the file and start a download' do
      post '/upload', file: { filename: 'example.csv', tempfile: tempfile.path }
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
