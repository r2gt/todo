require 'rails_helper'

feature 'Listing Todos' do
  scenario 'Trying access root_path without being logged in, en locale' do
    visit todo_items_path(locale: 'en')

    expect(page).to have_text 'Not authorized'
  end

  scenario 'Trying access root_path without being logged in, with pt-BR locale' do
    visit todo_items_path(locale: 'pt-BR')

    expect(page).to have_text 'Não autorizado'
  end

  context '' do
    background do
      sign_in
      TodoItem.create(description: 'Comprar Leite')
    end

    scenario 'lists all Todos, with English locale' do
      visit todo_items_path(locale: 'en')

      expect(page).to have_text("To-do list")
      expect(page).to have_text("Comprar Leite")
      expect(page).to have_link('Delete', count: 1, href: todo_item_path(TodoItem.last, locale: 'en'))
      expect(page).to have_link('Edit', count: 1, href: edit_todo_item_path(TodoItem.last, locale: 'en'))
      expect(page).to have_link('Show', count: 1, href: todo_item_path(TodoItem.last, locale: 'en'))
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
end
