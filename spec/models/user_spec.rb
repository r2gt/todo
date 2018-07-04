require 'rails_helper'

describe User do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
end
