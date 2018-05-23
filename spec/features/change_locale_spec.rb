require 'rails_helper'

feature 'Changing locale' do
  scenario 'Display portuguese main title' do
    visit root_path

    expect(page).to have_text("To-do list")

    visit root_path(locale: "pt-BR")

    expect(page).to have_text("Lista de afazeres")
  end
end
