class User < ApplicationRecord
  has_secure_password

  validates :name, :username, :email, :password, presence: true
end
