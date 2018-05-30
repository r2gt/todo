require 'rails_helper'

feature 'Listing Todos' do
  background do
    TodoItem.create(description: 'Comprar Leite')
  end

  scenario 'lists all Todos, with English locale' do
    visit todo_items_path

    expect(page).to have_text("To-do list")
    expect(page).to have_text("Comprar Leite")
    expect(page).to have_link('Delete', count: 1, href: todo_item_path(TodoItem.last, locale: nil))
    expect(page).to have_link('Edit', count: 1, href: edit_todo_item_path(TodoItem.last, locale: nil))
    expect(page).to have_link('Show', count: 1, href: todo_item_path(TodoItem.last, locale: nil))
  end

  scenario 'lists all Todos, with Brazilian Portuguese locale' do
    visit todo_items_path(locale: 'pt-BR')

    expect(page).to have_text("Lista de afazeres")
    expect(page).to have_text("Comprar Leite")
    expect(page).to have_link('Excluir', count: 1, href: todo_item_path(TodoItem.last, locale: 'pt-BR'))
    expect(page).to have_link('Editar', count: 1, href: edit_todo_item_path(TodoItem.last, locale: 'pt-BR'))
    expect(page).to have_link('Visualizar', count: 1, href: todo_item_path(TodoItem.last, locale: 'pt-BR'))
  end
end
