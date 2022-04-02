Rails.application.routes.draw do
  root :to => 'api/v1/posts#get_posts_list'

  namespace :api do
    namespace :v1 do
      get '/posts' => 'posts#get_posts_list'
      post '/posts' => 'posts#create_post'
      delete '/posts/:post_id' => 'posts#delete_post'
      put '/posts/:post_id' => 'posts#update_post'

      post '/user' => 'user#create_user'
      delete '/user/' => 'user#delete_user'

      post '/authenticate' => 'authentication#create'
    end
  end
end
