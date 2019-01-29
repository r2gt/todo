class Board < ApplicationRecord
  belongs_to :user
  has_many :todo_items, dependent: :destroy
  validates :name, presence: true
end
