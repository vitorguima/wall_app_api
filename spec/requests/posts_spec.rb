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

    it 'returns all posts' do
      FactoryBot.create(:post, title: 'The Silver Logic', content: 'I want to work for you', user_id: user.id)
      FactoryBot.create(:post, title: 'TSL', content: 'Am I passing the test?', user_id: user.id)
      
      get '/api/v1/posts'
  
      response_body = JSON.parse(response.body)
      response_first_item = response_body.first
      response_second_item = response_body.second
  
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
      expect(response_first_item['title']).to eq('The Silver Logic')
      expect(response_first_item['content']).to eq('I want to work for you')
      expect(response_second_item['title']).to eq('TSL')
      expect(response_second_item['content']).to eq('Am I passing the test?')
    end
  end

  describe 'POST /posts' do
    it 'create new post' do
      expect {
        post '/api/v1/posts', params: {
          post: { title: 'TSL', content: 'Am I passing the test?'}
        }, headers: {
          "Authorization" => "Bearer 123"
        }
      }.to change { Post.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
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
    let!(:post) { FactoryBot.create(:post, title: 'TSL', content: 'Am I passing the test?', user_id: user.id) }

    it 'deletes a post' do
      post_id = post.id
      expect {
        delete "/api/v1/posts/#{post_id}"
      }.to change { Post.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end