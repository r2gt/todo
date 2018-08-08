require "rails_helper"

feature 'Deleting a user' do
  background do
    @user = User.create(name: 'Foo', username: 'Bar', email: 'foo@bar.com', password: 'asd123')
  end

  context 'with english locale' do
    scenario 'Deleting an user and returning to index page' do
      visit users_url(locale: 'en')

      expect {
        click_link "delete_user_#{@user.id}"

        expect(page).to have_current_path users_path(locale: 'en')
        expect(page).to have_text('User was successfully deleted')
      }.to change(User, :count).from(1).to(0)
    end
  end

  context 'with Brazillian portuguese locale' do
    scenario 'Deleting successfully and returning to index page' do
      visit users_url(locale: 'pt-BR')

      expect {
        click_link "delete_user_#{@user.id}"

        expect(page).to have_current_path users_path(locale: 'pt-BR')
        expect(page).to have_text('Usuário excluído com sucesso')
      }.to change(User, :count).from(1).to(0)
    end
  end
end