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

  describe 'DELETE /user/:id' do
    let!(:user) { FactoryBot.create(:user,
      first_name: 'Jim',
      last_name: 'Morrison',
      email: 'jim_morrison@gmail.com',
      nickname: 'Jimmo',
      password: 'Jimpass'
    ) }
    let(:token) { AuthenticationTokenService.encode(user.id) }

    it 'Deletes an existing user' do
      expect {
        delete "/api/v1/user/#{user.id}", 
        headers: {
          'Authorization' => "Bearer #{token}",
        }
    }.to change { User.count }.from(1).to(0)
    end
  end
end