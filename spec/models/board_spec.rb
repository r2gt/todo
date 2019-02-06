require 'rails_helper'

RSpec.describe Board, type: :model do
  it { is_expected.to belong_to(:owner).with_foreign_key(:user_id).class_name('User') }
  it { is_expected.to have_many(:todo_items).dependent(:destroy) }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_and_belong_to_many :users  }
end
