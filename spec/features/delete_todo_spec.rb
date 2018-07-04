require "rails_helper"

feature 'Deleting a todo item' do
  background do
    @todo_item = TodoItem.create(description: 'Todo item a ser deletado')
  end

  scenario 'Deleting successfully and returning to index page with english locale' do
    visit todo_items_url(locale: 'en')

    expect {
      click_link "delete_todo_item_#{@todo_item.id}"

      expect(page).to have_current_path todo_items_path(locale: 'en')
      expect(page).to have_text('Todo item was successfully deleted')
    }.to change(TodoItem, :count).from(1).to(0)
  end

  scenario 'Deleting successfully and returning to index page with brazilian portuguese locale' do
    visit todo_items_url(locale: 'pt-BR')

    expect {
      click_link "delete_todo_item_#{@todo_item.id}"

      expect(page).to have_current_path todo_items_path(locale: 'pt-BR')
      expect(page).to have_text('Tarefa excluída com sucesso')
    }.to change(TodoItem, :count).from(1).to(0)
  end
end
