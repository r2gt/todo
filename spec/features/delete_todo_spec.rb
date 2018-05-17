require "rails_helper"

feature 'Deleting a todo item' do
  background do
    @todo_item = TodoItem.create(description: 'Todo item a ser deletado')
  end

  scenario 'Deleting successfully and returning to index page' do
    visit todo_items_url

    expect {
      click_link "delete_todo_item_#{@todo_item.id}"

      expect(current_path).to eql todo_items_path
      expect(page).to have_text('Todo item was successfully deleted !')
    }.to change(TodoItem, :count).from(1).to(0)
  end
end
