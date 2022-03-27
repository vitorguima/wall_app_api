require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    it 'authenticates the client' do
      post '/api/v1/authenticate', params: { username: 'usertest', password: 'passtest' }

      expect(response).to have_http_status(:created)

      response_body = JSON.parse(response.body)
      expect(response_body['token']).to eq('123')
    end

    it 'returns error when username is missing' do
      post '/api/v1/authenticate', params: { password: 'passtest' }

      expect(response).to have_http_status(:unprocessable_entity)

      response_body = JSON.parse(response.body)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: username'
      })
    end

    it 'returns error when password is missing' do
      post '/api/v1/authenticate', params: { username: 'usertest' }

      expect(response).to have_http_status(:unprocessable_entity)

      response_body = JSON.parse(response.body)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: password'
      })
    end
  end
end