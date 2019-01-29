require 'rails_helper'

feature 'Edit todo status' do
  background { sign_in_with_board }

  scenario 'transition from todo to done', js: true do
    create_todo
    visit board_path(@board, locale: 'en')

    find("#todo_item_#{@todo_item.id}").click

    @todo_item.reload

    expect(@todo_item).to be_done
  end

  scenario 'transition from done to todo', js: true do
    @todo_item = TodoItem.create(
      description: 'Comprar Leite',
      user_id: @user.id,
      board_id: @board.id,
      aasm_state: 'done'
    )

    visit board_path(@board, locale: 'en')

    find("#todo_item_#{@todo_item.id}").click

    @todo_item.reload

    expect(@todo_item).to be_todo
  end
end
