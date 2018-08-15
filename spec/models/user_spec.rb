require 'rails_helper'

describe User do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_length_of(:password).is_at_least(5).is_at_most(20) }

  describe '.find_by_username_or_email username_or_email' do
    context 'when user is found by username' do
      it 'returns user' do
        expect(
          described_class
        ).to receive(:find_by).once.with(username: 'foo').and_return subject

        expect(described_class.find_by_username_or_email('foo')).to eql subject
      end
    end

    context "when user isn't found by username" do
      it 'returns user found by email' do
        expect(
          described_class
        ).to receive(:find_by).once.with(username: 'foo').and_return nil

        expect(
          described_class
        ).to receive(:find_by).once.with(email: 'foo').and_return subject

        expect(described_class.find_by_username_or_email('foo')).to eql subject
      end
    end

    context "when user isn't found by username nor email" do
      it 'returns nil' do
        expect(
          described_class
        ).to receive(:find_by).once.with(username: 'foo').and_return nil

        expect(
          described_class
        ).to receive(:find_by).once.with(email: 'foo').and_return nil

        expect(described_class.find_by_username_or_email('foo')).to eql nil
      end
    end
  end
end
