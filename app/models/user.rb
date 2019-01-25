class User < ApplicationRecord
  has_secure_password
  has_many :todo_items
  has_many :boards

  validates :name, :username, :email, presence: true
  validates :password, length: 5..20

  after_create :generate_api_token

  def self.find_by_username_or_email(username_or_email)
    find_by(username: username_or_email).presence ||
      find_by(email: username_or_email)
  end

  def generate_api_token
    update(api_token: TokenService.create_for(self, :api_token))
  end
end
