require 'rails_helper'

feature 'Listing Todos' do
  background do
    @todo = TodoItem.create(description: 'Comprar Leite')
  end

  scenario 'lists all Todos' do
    visit todos_path

    expect(page).to have_text("TODOS")
    expect(page).to have_text("Comprar Leite")
  end
end
