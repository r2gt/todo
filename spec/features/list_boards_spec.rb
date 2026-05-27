require 'rails_helper'

feature 'Listing Boards' do
  scenario 'Trying access root_path without being logged in, en locale' do
    visit boards_path(locale: 'en')

    expect(page).to have_text 'Not authorized'
  end

  context 'with correct access' do
    background do
      sign_in

      another_user = User.create(
        name: 'Foo', username: 'Foo', email: 'foo@email.com',
        password: 'foo12345', password_confirmation: 'foo12345', admin:true
      )

      @board1 = Board.create(name: 'Board 1', user_id: @user.id)
      @board2 = Board.create(name: 'Board 2', user_id: another_user.id)
    end

    scenario 'with English locale' do
      visit boards_path(locale: 'en')

      expect(page).to have_text("list Boards")
      expect(page).to have_text(@board1.name)
      expect(page).not_to have_text(@board2.name)
      expect(page).to have_link('Delete', count: 1, href: board_path(@board1, locale: 'en'))
      expect(page).to have_link('Edit', count: 1, href: edit_board_path(@board1, locale: 'en'))
      expect(page).to have_link('Show', count: 1, href: board_path(@board1, locale: 'en'))
    end
  end
end
