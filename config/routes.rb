Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/posts' => 'posts#get_posts_list'
      post '/posts' => 'posts#create_post'
      delete '/posts/:id' => 'posts#delete_post'
    end
  end
end
