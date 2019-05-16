require 'rails_helper'

feature "Editing Todo" do
  background do
    sign_in_with_board
    create_todo
  end

  scenario "updates Todo successfully, with English locale" do
    visit edit_board_todo_item_path(@board, @todo_item, locale: 'en')

    fill_in "Description", with: "Ag é Silver"
    click_button "Update Todo item"

    expect(page).to have_content("Todo item was successfully updated")
    expect(page).to have_current_path(board_path(@board, locale: 'en'))
  end

  scenario "updates Todo successfully, with Brazilian Portuguese locale" do
    visit edit_board_todo_item_path(@board, @todo_item, locale: 'pt-BR')

    fill_in "Descrição", with: "Ag é Silver"
    click_button "Atualizar Tarefa"

    expect(page).to have_content("Tarefa atualizada com sucesso")
    expect(page).to have_current_path(board_path(@board, locale: 'pt-BR'))
  end

  scenario "updates Todo with failure" do
    visit edit_board_todo_item_path(@board, @todo_item, locale: 'en')

    fill_in "Description", with: ""
    click_button "Update Todo item"

    expect(page).to have_content("can't be blank")
    expect(page).to have_content("Description")
    expect(page).to have_current_path(board_todo_item_path(@board, @todo_item, locale: 'en'))
  end

  scenario "tries to update another user's todo_item" do
    user2 = User.create(
      name: 'another', username: 'another', email: 'ano@ther.com', password: 'teste'
    )

    board2 = user2.owner_boards.create(name: 'Board 2')

    todo_item2 = TodoItem.create(
      description: 'Comprar Leite', user_id: user2.id, board_id: board2.id
    )

    expect{
      visit edit_board_todo_item_path(board2, todo_item2, locale: 'en')
    }.to raise_error ActiveRecord::RecordNotFound
  end
end
