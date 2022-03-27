require 'rails_helper'

describe 'User register', type: :request do
  describe 'POST /user' do
    it 'Creates a new user' do
      post '/api/v1/authenticate', params: { 
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'email@email.com',
        nickname: 'nickname',
        password: 'password'
      }

      expect(response).to have_http_status(:created)
    end
  end
end