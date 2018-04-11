require 'rails_helper'

feature 'Listing Todos' do
  scenario 'lists all Todos' do
    visit todos_path

    expect(page).to have_text("TODOS")
  end
end
