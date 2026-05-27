require 'rails_helper'

feature 'Creating board' do
  background do
    sign_in
  end

  scenario 'with success' do
    visit new_board_path(locale: 'en')

    expect {
      fill_in('Name', with: 'Board 1')
      click_button('Create Board')

      expect(page).to have_text 'Board was successfully created'
      expect(page).to have_current_path boards_path(locale: 'en')
    }.to change(Board, :count).by(1)
  end

  scenario 'with invalid name' do
    visit new_board_path(locale: 'en')

    expect {
      fill_in('Name', with: '')
      click_button('Create Board')

      expect(page).to have_text "Name can't be blank"
    }.not_to change(Board, :count)
  end
end
