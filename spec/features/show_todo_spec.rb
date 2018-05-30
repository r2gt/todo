require 'rails_helper'

feature 'Showing todo' do
  background do
    @todo = TodoItem.create(description: 'Comprar Leite')
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
end
