class TodoItem < ApplicationRecord
  include AASM

  belongs_to :user
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
