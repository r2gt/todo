require "rails_helper"

describe ApplicationController do
  it '#default_url_options' do
    expect(subject.default_url_options).to eql(locale: I18n.locale)
  end

  describe '#current_user' do
    let(:user) do
      User.create(
        name: 'Foo', username: 'Bar', email: 'email@email.com', 
        password: 'asdf12345'
      )
    end

    context 'With current_user_id on session' do
      it 'returns user found by id' do
        allow(
          subject
        ).to receive(:session).and_return(current_user_id: user.id)

        expect(subject.current_user).to eql(user)
      end
    end

    context 'without current_user_id on session' do
      it 'returns nil' do
        expect(subject.current_user).to be_nil
      end
    end
  end

  describe '#logged_in?' do
    let(:user) { double(:user) }

    context 'when current_user exists' do
      it 'is logged in' do
        expect(subject).to receive(:current_user).once.and_return(user)
        expect(subject).to be_logged_in
      end
    end

    context 'when current user is nil' do
      it "isn't logged in" do
        expect(subject).to receive(:current_user).once.and_return(nil)
        expect(subject).not_to be_logged_in
      end
    end
  end
end
