require 'rails_helper'

describe 'Posts API', type: :request do
  describe 'GET /posts' do
    it 'returns all posts' do
      FactoryBot.create(:post, title: 'The Silver Logic', content: 'I want to work for you')
      FactoryBot.create(:post, title: 'TSL', content: 'Am I passing the test?')
      
      get '/api/v1/posts'
  
      response_content = JSON.parse(response.body)
      response_first_item = response_content.first
      response_second_item = response_content.second
  
      expect(response).to have_http_status(:success)
      expect(response_content.size).to eq(2)
      expect(response_first_item['title']). to eq('The Silver Logic')
      expect(response_first_item['content']). to eq('I want to work for you')
      expect(response_second_item['title']). to eq('TSL')
      expect(response_second_item['content']). to eq('Am I passing the test?')
    end
  end

  describe 'POST /posts' do
    it 'create new post' do
      expect {
        post '/api/v1/posts', params: { post: { title: 'TSL', content: 'Am I passing the test?' } }
      }.to change { Post.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /posts/:id' do
    let!(:post) { FactoryBot.create(:post, title: 'TSL', content: 'Am I passing the test?') }

    it 'deletes a post' do
      expect {
        delete "/api/v1/posts/#{post.id}"
      }.to change { Post.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end