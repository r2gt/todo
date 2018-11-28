class TodoItem < ApplicationRecord
  include AASM

  belongs_to :user
  validates :description, presence: true

  aasm do
    state :todo, :initial => true
    state :done

    event :run do
      transitions :from => :todo, :to => :done
    end

    event :undo do
      transitions :from => :done, :to => :todo
    end
  end
end
