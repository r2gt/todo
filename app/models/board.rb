class Board < ApplicationRecord
  belongs_to :owner, foreign_key: :user_id, class_name: 'User'
  has_many :todo_items, dependent: :destroy
  validates :name, presence: true
  has_and_belongs_to_many :users
end
