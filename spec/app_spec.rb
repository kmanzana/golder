require 'spec_helper'

describe 'App' do
  it 'main page' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('madness')
  end
end