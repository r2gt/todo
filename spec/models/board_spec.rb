require 'rails_helper'

RSpec.describe Board, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many(:todo_items).dependent(:destroy) }
  it { is_expected.to validate_presence_of :name }
end
