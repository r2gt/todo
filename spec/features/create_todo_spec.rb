require 'rails_helper'

feature 'Creating todo' do
  background { sign_in_with_board }

  scenario 'Create todo, using English locale' do
    visit new_board_todo_item_path(@board, locale: 'en')

    expect {
      fill_in('Description', with: 'John')
      click_button('Create Todo item')

      expect(page).to have_text 'Todo item was successfully created'
      expect(page).to have_current_path board_path(@board, locale: 'en')
    }.to change(TodoItem, :count).by(1)
  end

  scenario 'Create todo, using Brazilian Portuguese locale' do
    visit new_board_todo_item_path(@board, locale: 'pt-BR')

    expect {
      fill_in('Descrição', with: 'John')
      click_button('Criar Tarefa')

      expect(page).to have_text 'Tarefa criada com sucesso'
      expect(page).to have_current_path board_path(@board, locale: 'pt-BR')
    }.to change(TodoItem, :count).by(1)
  end

  scenario 'Validates description' do
    visit new_board_todo_item_path(@board, locale: 'en')

    expect {
      fill_in('Description', with: '')
      click_button('Create Todo item')

      expect(page).to have_text "Description can't be blank"
    }.not_to change(TodoItem, :count)
  end
end
