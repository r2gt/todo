require "rails_helper"

describe CreationService do
  let(:resource) { double(:resource) }
  let(:params) {{ name: "admin", username: "admin", email: "admin@admin.com" }}

  subject { described_class.new(resource) }

  before do
    expect(resource).to receive(:assign_attributes).with(params).once
  end

  it 'return true when save with success' do
    expect(resource).to receive(:save).once.and_return true
    expect(subject.perform(params)).to be true
  end

  it 'return false when failed save' do
    expect(resource).to receive(:save).once.and_return false

    expect(subject.perform(params)).to be false
  end
end
