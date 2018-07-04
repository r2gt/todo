require 'rails_helper'

describe User do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_length_of(:password).is_at_least(5).is_at_most(20) }
end
