class User < ApplicationRecord
  has_secure_password

  validates :name, :username, :email, presence: true
  validates :password, length: 5..20
end
