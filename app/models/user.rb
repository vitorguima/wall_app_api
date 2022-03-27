class User < ApplicationRecord
  has_many :posts

  validates :first_name, presence: true,
  validates :last_name, presence: true,
  validates :email, presence: true, uniqueness: true
  validates :nickname, presence: true
  validates :password, true 

  # creates custom validation for email
end
