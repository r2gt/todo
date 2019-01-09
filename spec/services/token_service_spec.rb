require "rails_helper"

describe TokenService do
  subject { described_class }

  describe ".create_for entity, token_key" do
    let(:entity) { User.new }

    it "creates random token and binds to account" do
      expect(SecureRandom).to receive(:hex).once.and_return("FOO")
      expect(User).to receive(:exists?).once.with(api_token: "FOO").and_return(false)

      expect(subject.create_for(entity, :api_token)).to eql "FOO"
    end

    it "does not repeat tokens" do
      expect(SecureRandom).to receive(:hex).once.and_return("FOO")
      expect(User).to receive(:exists?).once.with(api_token: "FOO").and_return(true)
      expect(SecureRandom).to receive(:hex).once.and_return("BAR")
      expect(User).to receive(:exists?).once.with(api_token: "BAR").and_return(false)

      expect(subject.create_for(entity, :api_token)).to eql "BAR"
    end
  end
end
