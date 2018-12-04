require 'rails_helper'

feature 'Edit todo status' do
  background { sign_in }

  scenario 'transition from todo for done', js: true do
    todo_item = TodoItem.create(description: 'Comprar Leite', user_id: @user.id)

    visit todo_items_path(locale: 'en')
    
    find("#todo_item_#{todo_item.id}").click

    todo_item.reload

    expect(todo_item.done?).to eq true
  end

  scenario 'transition from done to todo', js: true do
    todo_item = TodoItem.create(description: 'Comprar Leite', user_id: @user.id, aasm_state: 'done')

    visit todo_items_path(locale: 'en')

    find("#todo_item_#{todo_item.id}").click

    todo_item.reload

    expect(todo_item.todo?).to eq true
  end
end