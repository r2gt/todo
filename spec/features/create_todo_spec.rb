require 'rails_helper'

feature 'Creating todo' do
  scenario 'Create todo' do
    visit new_todo_item_path

    fill_in('Description', with: 'John')
    click_button('Save')
        
    expect(page).to have_text 'Todo item was successfully created'
  end

  scenario 'Validates description' do
    visit new_todo_item_path

    fill_in('Description', with: '')
    click_button('Save')
        
    expect(page).to have_text "Description can't be blank"
  end
end
