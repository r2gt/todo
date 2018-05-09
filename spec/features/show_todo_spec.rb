require 'rails_helper'

feature 'Showing todo' do
  background do
    @todo = TodoItem.create(description: 'Comprar Leite')
  end

  scenario 'Display details' do
    visit todo_item_path(@todo)

    expect(page).to have_text("Comprar Leite")
  end
end
