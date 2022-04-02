class User < ApplicationRecord
  has_many :posts
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :nickname, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validate :email_format

  after_destroy :destroy_posts

  private

  def email_format
    pattern = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    email = self.email
    
    if pattern =~ email
      return
    else
      self.errors.add(:email, 'Invalid email format')
    end
  end

  def destroy_posts
    self.posts.destroy_all
  end
end
