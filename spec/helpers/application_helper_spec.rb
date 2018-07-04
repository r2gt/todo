require "rails_helper"

describe ApplicationHelper do
  describe '#locale_links exclude:' do
    it 'returns a map of links for accepted locales, without excluded locale option' do
      expect(
        helper.locale_links(exclude: 'pt-BR')
      ).to eql ["<a href=\"/en\">English</a>"]
    end
  end
end
