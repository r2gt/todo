class TodoItem < ApplicationRecord
  include AASM

  aasm do
  end
  belongs_to :user
  validates :description, presence: true
end
