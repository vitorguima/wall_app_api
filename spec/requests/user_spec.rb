require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    it 'authenticates the client' do
      post '/api/v1/authenticate', params: { username: 'test-name', password: 'test-pass' }

      expect(response).to have_http_status(:created)
    end
  end
end