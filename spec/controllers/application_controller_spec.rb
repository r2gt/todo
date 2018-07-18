require "rails_helper"

describe ApplicationController do
  it '#default_url_options' do
    expect(subject.default_url_options).to eql(locale: I18n.locale)
  end
end
