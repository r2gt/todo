require 'rails_helper'

RSpec.describe TodoItem, type: :model do
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:board) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to be_kind_of AASM }
  it { is_expected.to transition_from(:todo).to(:done).on_event :switch }
  it { is_expected.to transition_from(:done).to(:todo).on_event :switch }
end
