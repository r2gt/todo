require 'rails_helper'

feature "Editing Todo" do
  background do
    @todo = TodoItem.create(description: "Life Changer")
  end

  scenario "updates Todo successfully" do
    visit edit_todo_item_path(@todo)

    fill_in "Description", with: "Ag é Silver"
    click_button "Update Todo item"

    expect(page).to have_content("Todo item was successfully updated")
    expect(current_path).to eql(todo_item_path(@todo))
  end

  scenario "updates Todo with failure" do
    visit edit_todo_item_path(@todo)

    fill_in "Description", with: ""
    click_button "Update Todo item"

    expect(page).to have_content("can't be blank")
    expect(page).to have_content("Description")
    expect(current_path).to eql(todo_item_path(@todo))
  end
end
