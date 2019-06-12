require 'rails_helper'

feature 'Showing board' do
  background do
    sign_in_with_board
    create_todo
  end

  scenario 'Display details in English' do
    visit board_path(@board, locale: :en)

    expect(page).to have_text @board.name
    expect(page).to have_text @board.todo_items.first.description
    expect(page).to have_text('Comentario')

    expect(page).to have_link(
      'Edit', href: edit_board_todo_item_path(@board, @todo_item, locale: :en)
    )
  end

  scenario 'tries to show another user board' do
    another_user = User.create(
      name: 'another', username: 'another', email: 'ano@ther.com', password: 'teste'
    )

    another_board = another_user.owner_boards.create(name: 'Board show')

    expect{
      visit board_path(another_board, locale: :en)
    }.to raise_error ActiveRecord::RecordNotFound
  end
end
