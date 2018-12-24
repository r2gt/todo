require 'rails_helper'

RSpec.describe TodoItem, type: :model do
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to belong_to(:user) }
end
