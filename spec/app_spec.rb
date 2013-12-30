require 'spec_helper'

describe 'App' do
  describe 'main page' do
    it 'should display the main page' do
      get '/'

      last_response.should be_ok
      last_response.status.should == 200 # rubocop:disable Void
      last_response.body.should include('Golder Contracting')
    end
  end

  describe 'page that doesn\'t exist' do
    it 'should return a 404' do
      get '/not_here'

      last_response.status.should == 404  # rubocop:disable Void
      last_response.body.should == 'page not found'
    end
  end
end
