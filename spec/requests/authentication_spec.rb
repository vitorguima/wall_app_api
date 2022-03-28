require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    let(:user) { FactoryBot.create(:user,
      first_name: 'Jim',
      last_name: 'Morrison',
      email: 'jim_morrison@gmail.com',
      nickname: 'Jimmo',
      password: 'Jimpass'
    ) }
    
    let(:token) { AuthenticationTokenService.encode(user.id) }

    it 'authenticates the client' do
      post '/api/v1/authenticate', params: { email: user.email, password: user.password }

      expect(response).to have_http_status(:created)

      response_body = JSON.parse(response.body)
      expect(response_body['token']).to eq(token)
    end

    it 'returns error when username is missing' do
      post '/api/v1/authenticate', params: { password: user.password }

      expect(response).to have_http_status(:unprocessable_entity)

      response_body = JSON.parse(response.body)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: email'
      })
    end

    it 'returns error when password is missing' do
      post '/api/v1/authenticate', params: { email: user.email }

      expect(response).to have_http_status(:unprocessable_entity)

      response_body = JSON.parse(response.body)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: password'
      })
    end

    it 'returns error when password does not match' do
      post '/api/v1/authenticate', params: { email: user.email, password: 'wrongpassword' }

      expect(response).to have_http_status(:unauthorized)

      # response_body = JSON.parse(response.body)
      # expect(response_body['token']).to eq(token)
    end
  end
end