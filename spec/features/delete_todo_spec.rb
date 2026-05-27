require "rails_helper"

feature 'Deleting a todo item' do
  background do
    sign_in_with_board
    create_todo
  end

  scenario 'Deleting successfully and returning to index page with english locale' do
    visit board_path(@board, locale: 'en')

    expect {
      click_link "delete_todo_item_#{@todo_item.id}"

      expect(page).to have_current_path board_path(@board, locale: 'en')
      expect(page).to have_text('Todo item was successfully deleted')
    }.to change(TodoItem, :count).from(1).to(0)
  end

  scenario 'Deleting successfully and returning to index page with brazilian portuguese locale' do
    visit board_path(@board, locale: 'pt-BR')

    expect {
      click_link "delete_todo_item_#{@todo_item.id}"

      expect(page).to have_current_path board_path(@board, locale: 'pt-BR')
      expect(page).to have_text('Tarefa excluída com sucesso')
    }.to change(TodoItem, :count).from(1).to(0)
  end
end
