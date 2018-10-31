class User < ApplicationRecord
  has_secure_password
  has_many :todo_items

  validates :name, :username, :email, presence: true
  validates :password, length: 5..20

  def self.find_by_username_or_email(username_or_email)
    find_by(username: username_or_email).presence ||
      find_by(email: username_or_email)
  end
end
