require 'rails_helper'

describe 'User register', type: :request do
  describe 'POST /users' do
    it 'Creates a new user' do
      expect {
        post '/api/v1/users', params: {
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
        post '/api/v1/users', params: {
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
        expect(response_body).to eq({ "error" => { "message" => "Validation failed: Email has already been taken" } })
      end
    end

    context 'nickname already exists' do
      let!(:user) { FactoryBot.create(:user,
        first_name: 'Jim',
        last_name: 'Morrison',
        email: 'jim_morrison2@gmail.com',
        nickname: 'Jimalready',
        password: 'Jimpass'
      ) }

      it 'return status 422' do
        post '/api/v1/users', params: {
          user: {
            first_name: 'Hommer',
            last_name: 'Simpsons',
            email: 'hommersimpsons@gmail.com',
            nickname: 'Jimalready',
            password: 'Jimpass'
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        response_body = JSON.parse(response.body)
        expect(response_body).to eq({ "error" => { "message" => "Validation failed: Nickname has already been taken" } })
      end
    end

    context 'nickname length is smaller than 5' do
      it 'return status 422' do
        post '/api/v1/users', params: {
          user: {
            first_name: 'first_name',
            last_name: 'last_name',
            email: 'email@email.com',
            nickname: 'nic',
            password: 'password',
          }
        }
  
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'nickname length is higher than 15' do
      it 'return status 422' do
        post '/api/v1/users', params: {
          user: {
            first_name: 'first_name',
            last_name: 'last_name',
            email: 'email@email.com',
            nickname: 'nicishigherthan15',
            password: 'password',
          }
        }
  
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'password length is smaller than 7' do
      it 'return status 422' do
        post '/api/v1/users', params: {
          user: {
            first_name: 'first_name',
            last_name: 'last_name',
            email: 'email@email.com',
            nickname: 'nicishigherthan15',
            password: 'passwo',
          }
        }
  
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'password length is bigger than 20' do
      it 'return status 422' do
        post '/api/v1/users', params: {
          user: {
            first_name: 'first_name',
            last_name: 'last_name',
            email: 'email@email.com',
            nickname: 'nicishigherthan15',
            password: 'passwordismuchbiggerthan20',
          }
        }
  
        expect(response).to have_http_status(:unprocessable_entity)
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
        delete "/api/v1/users", 
        headers: {
          'Authorization' => "Bearer #{token}",
        }
    }.to change { User.count }.from(1).to(0)
    end

    it 'Deletes associated posts' do
      expect {
        delete "/api/v1/users", 
        headers: {
          'Authorization' => "Bearer #{token}",
        }
    }.to change { Post.count }.from(1).to(0)
    end
  end
end
