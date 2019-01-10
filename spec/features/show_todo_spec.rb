require 'rails_helper'

feature 'Showing todo' do
  background do
    sign_in

    @todo = @user.todo_items.create(description: 'Comprar Leite')
  end

  scenario 'Display details in English' do
    visit todo_item_path(@todo, locale: :en)
    expect(page).to have_text("Details to-do")
    expect(page).to have_text("Comprar Leite")
    expect(page).to have_link('Edit', href: edit_todo_item_path(@todo, locale: :en))
  end

  scenario 'Display details in Brazilian Portuguese' do
    visit todo_item_path(@todo, locale: 'pt-BR')
    expect(page).to have_text("Detalhes da tarefa")
    expect(page).to have_text("Comprar Leite")
    expect(page).to have_link('Editar', href: edit_todo_item_path(@todo, locale: 'pt-BR'))
  end

  scenario "tries to show another user todo_item" do
    another_user = User.create(
      name: 'another', username: 'another', email: 'ano@ther.com', password: 'teste'
    )

    another_todo = another_user.todo_items.create(description: 'Todo item show')

    expect{
      visit todo_item_path(another_todo, locale: :en)
    }.to raise_error ActiveRecord::RecordNotFound
  end
end
