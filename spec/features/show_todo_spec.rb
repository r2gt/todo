require 'rails_helper'

feature 'Showing todo' do
  background do
    sign_in_with_board
    create_todo
  end

  scenario 'Display details in English' do
    visit board_todo_item_path(@board, @todo_item, locale: :en)
    expect(page).to have_text('Details to-do')
    expect(page).to have_text('Todo item 1')
    expect(page).to have_text('Comentario')

    expect(page).to have_link(
      'Edit', href: edit_board_todo_item_path(@board, @todo_item, locale: :en)
    )
  end

  scenario 'Display details in Brazilian Portuguese' do
    visit board_todo_item_path(@board, @todo_item, locale: 'pt-BR')
    expect(page).to have_text('Detalhes da tarefa')
    expect(page).to have_text('Todo item 1')
    expect(page).to have_text('Comentario')

    expect(page).to have_link(
      'Editar',
      href: edit_board_todo_item_path(@board, @todo_item, locale: 'pt-BR')
    )
  end

  scenario 'tries to show another user todo_item' do
    another_user = User.create(
      name: 'another', username: 'another', email: 'ano@ther.com', password: 'teste'
    )

    another_board = another_user.owner_boards.create(name: 'Board show')

    another_todo = another_board.todo_items.create(
      description: 'Todo item show', user: another_user
    )

    expect{
      visit board_todo_item_path(another_board, another_todo, locale: :en)
    }.to raise_error ActiveRecord::RecordNotFound
  end
end
