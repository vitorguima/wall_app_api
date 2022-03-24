Rails.application.routes.draw do
  get '/posts' => 'posts#get_posts_list'
  post '/posts' => 'posts#create_post'
  delete '/posts/:id' => 'posts#delete_post'
end
