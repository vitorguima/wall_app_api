class User < ApplicationRecord
  has_many :posts

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :nickname, presence: true
  validates :password, presence: true
  validates :email, presence: true, uniqueness: true
end
