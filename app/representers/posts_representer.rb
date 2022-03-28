class PostsRepresenter
  def initialize(posts)
    @posts = posts
  end

  def as_json
    posts.map do |post|
      {
        id: post.id,
        title: post.title,
        content: post.content,
        author_nickname: post.user.nickname,
        created_at: post.created_at,
        updated_at: post.updated_at,
      }
    end
  end

  private

  attr_reader :posts
end
