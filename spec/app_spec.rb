# rubocop:disable Void
require 'spec_helper'

describe 'App' do
  describe 'main page' do
    it 'should display the main page' do
      get '/'

      last_response.should be_ok
      last_response.body.should include('madness')
    end
  end

  describe 'page that doesn\'t exist' do
    it 'should return a 404' do
      get '/not_here'

      last_response.status.should == 404
      last_response.body.should == 'page not found'
    end
  end
end
