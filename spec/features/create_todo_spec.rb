require 'rails_helper'

feature 'Creating todo' do
  scenario 'Create todo, using English locale' do
    visit new_todo_item_path

    fill_in('Description', with: 'John')
    click_button('Create Todo item')

    expect(page).to have_text 'Todo item was successfully created'
    expect(page).to have_current_path todo_items_path
  end

  scenario 'Create todo, using Brazilian Portuguese locale' do
    visit new_todo_item_path(locale: 'pt-BR')

    fill_in('Descrição', with: 'John')
    click_button('Criar Tarefa')

    expect(page).to have_text 'Tarefa criada com sucesso'
    expect(page).to have_current_path todo_items_path(locale: 'pt-BR')
  end

  scenario 'Validates description' do
    visit new_todo_item_path

    fill_in('Description', with: '')
    click_button('Create Todo item')

    expect(page).to have_text "Description can't be blank"
  end
end
