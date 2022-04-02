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

    context 'email already exists' do
      let!(:user) { FactoryBot.create(:user,
        first_name: 'Jim',
        last_name: 'Morrison',
        email: 'jim_morrison@gmail.com',
        nickname: 'Jimmoxxxxx',
        password: 'Jimpass'
      ) }

      it 'return status 422' do
        post '/api/v1/user', params: {
          user: {
            first_name: 'Jim',
            last_name: 'Morrison',
            email: 'jim_morrison@gmail.com',
            nickname: 'Jimmo',
            password: 'Jimpass'
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        response_body = JSON.parse(response.body)
        expect(response_body).to eq({'email' => ['has already been taken']})
      end
    end

    context 'nickname already exists' do
      let!(:user) { FactoryBot.create(:user,
        first_name: 'Jim',
        last_name: 'Morrison',
        email: 'jim_morrison2@gmail.com',
        nickname: 'Jim',
        password: 'Jimpass'
      ) }

      it 'return status 422' do
        post '/api/v1/user', params: {
          user: {
            first_name: 'Hommer',
            last_name: 'Simpsons',
            email: 'hommersimpsons@gmail.com',
            nickname: 'Jim',
            password: 'Jimpass'
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        response_body = JSON.parse(response.body)
        expect(response_body).to eq({'nickname' => ['has already been taken']})
      end
    end
  end

  describe 'DELETE /user' do
    let!(:user) { FactoryBot.create(:user,
      first_name: 'Jim',
      last_name: 'Morrison',
      email: 'jim_morrison@gmail.com',
      nickname: 'Jimmo',
      password: 'Jimpass'
    ) }
    let(:token) { AuthenticationTokenService.encode(user.id) }
    let!(:first_post) { FactoryBot.create(:post,
      title: 'The Silver Logic',
      content: 'I want to work for you',
      user_id: user.id
    ) }

    it 'Deletes an existing user' do
      expect {
        delete "/api/v1/user/", 
        headers: {
          'Authorization' => "Bearer #{token}",
        }
    }.to change { User.count }.from(1).to(0)
    end

    it 'Deletes associated posts' do
      expect {
        delete "/api/v1/user/", 
        headers: {
          'Authorization' => "Bearer #{token}",
        }
    }.to change { Post.count }.from(1).to(0)
    end
  end
end
