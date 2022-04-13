require 'rails_helper'

describe 'Posts API', type: :request do
  describe 'GET /posts' do
    let(:user) { FactoryBot.create(:user,
      first_name: 'Jim',
      last_name: 'Morrison',
      email: 'jim_morrison@gmail.com',
      nickname: 'Jimmo',
      password: 'Jimpass'
    ) }
    let!(:first_post) { FactoryBot.create(:post, title: 'The Silver Logic', content: 'I want to work for you', user_id: user.id) }
    let!(:second_post) { FactoryBot.create(:post, title: 'TSL', content: 'Am I passing the test?', user_id: user.id) }

    it 'returns all posts' do  
      get '/api/v1/posts'
  
      response_body = JSON.parse(response.body)
      response_first_item = response_body.first
      response_second_item = response_body.second
  
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
      expect(response_first_item['title']).to eq(second_post.title)
      expect(response_first_item['content']).to eq(second_post.content)
      expect(response_second_item['title']).to eq(first_post.title)
      expect(response_second_item['content']).to eq(first_post.content)
    end
  end

  describe 'POST /posts' do
    let(:user) { FactoryBot.create(:user,
      first_name: 'Jim',
      last_name: 'Morrison',
      email: 'jim_morrison@gmail.com',
      nickname: 'Jimmo',
      password: 'Jimpass'
    ) }
    let(:token) { AuthenticationTokenService.encode(user.id) }

    it 'create new post' do
      expect {
        post '/api/v1/posts', params: {
          post: { title: 'TSL', content: 'Am I passing the test?', user_id: user.id }
        }, headers: {
          'Authorization' => "Bearer #{token}"
        }
      }.to change { Post.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end

    context 'missing Authorization header' do
      it 'returns status 401' do
        post '/api/v1/posts', params: {}, headers: {}

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'missing body params' do
      it 'returns status 422' do
        post '/api/v1/posts', params: {
          post: { title: '', content: '', user_id: user.id }
        }, headers: {
          'Authorization' => "Bearer #{token}"
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /posts/:id' do
    let(:user) { FactoryBot.create(:user,
      first_name: 'Jim',
      last_name: 'Morrison',
      email: 'jim_morrison@gmail.com',
      nickname: 'Jimmo',
      password: 'Jimpass'
    ) }
    let(:token) { AuthenticationTokenService.encode(user.id) }
    let!(:post) { FactoryBot.create(:post, title: 'TSL', content: 'Am I passing the test?', user_id: user.id) }

    it 'deletes a post' do
      expect {
        delete "/api/v1/posts/#{post.id}",
        headers: {
          "Authorization" => "Bearer #{token}",
        }
      }.to change { Post.count }.from(1).to(0)

      expect(response).to have_http_status(:ok)
    end

    context 'missing Authorization header' do
      it 'returns status 401' do
        delete "/api/v1/posts/#{post.id}", params: {}, headers: {}

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
  
  describe 'PUT /posts/:id' do
    let(:user) { FactoryBot.create(:user,
      first_name: 'Jim',
      last_name: 'Morrison',
      email: 'jim_morrison@gmail.com',
      nickname: 'Jimmo',
      password: 'Jimpass'
    ) }
    let!(:post) { FactoryBot.create(:post, title: 'The Silver Logic', content: 'I want to work for you', user_id: user.id) }
    let(:token) { AuthenticationTokenService.encode(user.id) }

    it 'update an existing post' do
      put "/api/v1/posts/#{post.id}", params: {
        post: { title: 'TSL', content: 'Am I passing the test?', user_id: user.id }
      }, headers: {
        'Authorization' => "Bearer #{token}"
      }

      updated_post = Post.find(post.id)

      expect(response).to have_http_status(:created)
      expect(updated_post.title).to eq('TSL')
      expect(updated_post.content).to eq('Am I passing the test?')
    end

    context 'missing Authorization header' do
      it 'returns status 401' do
        put '/api/v1/posts/1', params: {}, headers: {}

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
