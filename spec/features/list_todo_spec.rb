require 'rails_helper'

feature 'Listing Todos' do
  background do
    TodoItem.create(description: 'Comprar Leite')
  end

  scenario 'lists all Todos' do
    visit todo_items_path

    expect(page).to have_text("To-do list")
    expect(page).to have_text("Comprar Leite")
  end
end
