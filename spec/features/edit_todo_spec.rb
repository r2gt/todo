require 'rails_helper'

feature "Editing Todo" do
  background do
    sign_in
    @todo = @user.todo_items.create(description: "Life Changer")
  end

  scenario "updates Todo successfully, with English locale" do
    visit edit_todo_item_path(@todo, locale: 'en')

    fill_in "Description", with: "Ag é Silver"
    click_button "Update Todo item"

    expect(page).to have_content("Todo item was successfully updated")
    expect(page).to have_current_path(todo_item_path(@todo, locale: 'en'))
  end

  scenario "updates Todo successfully, with Brazilian Portuguese locale" do
    visit edit_todo_item_path(@todo, locale: 'pt-BR')

    fill_in "Descrição", with: "Ag é Silver"
    click_button "Atualizar Tarefa"

    expect(page).to have_content("Tarefa atualizada com sucesso")
    expect(page).to have_current_path(todo_item_path(@todo, locale: 'pt-BR'))
  end

  scenario "updates Todo with failure" do
    visit edit_todo_item_path(@todo, locale: 'en')

    fill_in "Description", with: ""
    click_button "Update Todo item"

    expect(page).to have_content("can't be blank")
    expect(page).to have_content("Description")
    expect(page).to have_current_path(todo_item_path(@todo, locale: 'en'))
  end

  scenario "tries to update another user todo_item" do
    another_user = User.create(
      name: 'another', username: 'another', email: 'ano@ther.com', password: 'teste'
    )

    another_todo = another_user.todo_items.create(description: 'Todo item show')

    expect{
      visit edit_todo_item_path(another_todo, locale: 'en')
    }.to raise_error ActiveRecord::RecordNotFound
  end
end
