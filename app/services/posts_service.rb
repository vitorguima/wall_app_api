class PostsService
  def self.get_posts
    posts = Post.all
  end

  def self.new_post(params)
    new_post = Post.new(params)
  end
end