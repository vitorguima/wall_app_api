Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/posts' => 'posts#get_posts_list'
      post '/posts' => 'posts#create_post'
      delete '/posts/:id' => 'posts#delete_post'

      post '/user' => 'user#create_user'

      post '/authenticate' => 'authentication#create'
    end
  end
end
