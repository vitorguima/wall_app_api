require 'rails_helper'

describe 'User register', type: :request do
  describe 'POST /user' do
    it 'Creates a new user' do
      expect {
        post '/api/v1/user', params: {
          user: {
            first_name: 'first_name',
            last_name: 'last_name',
            email: 'email@email.com',
            nickname: 'nickname',
            password: 'password',
          }
        }
      }.to change { User.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end
end