class TodoItem < ApplicationRecord
  validates :description, presence: true
end
