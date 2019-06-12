class TodoItem < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :board
  has_many :comments, as: :commentable

  validates :description, presence: true

  aasm do
    state :todo, :initial => true
    state :done

    event :switch do
      transitions :from => :todo, :to => :done, :if => :todo?
      transitions :from => :done, :to => :todo, :if => :done?
    end
  end
end
