require 'rails_helper'

feature 'Editing User' do
  background do
    sign_in

    @user = User.create(
      name: 'Foo', username: 'Bar', email: 'foo@bar.com', password: '12345'
    )
  end

  scenario 'updates User successfully, with English locale' do
    visit users_path

    click_link "edit_user_#{@user.id}"

    fill_in 'Name', with: 'FooBar'
    fill_in 'Username', with: 'foobar'
    fill_in 'E-mail', with: 'foobar@foobar.com'
    fill_in 'Password', with: 'foobar'
    fill_in 'Password confirmation', with: 'foobar'

    click_button 'Update User'

    expect(page).to have_content('User was successfully updated')
    expect(page).to have_current_path(user_path(@user, locale: 'en'))
  end

  scenario 'updates User successfully, with portuguese locale' do
    visit users_path(locale: 'pt-BR')

    click_link "edit_user_#{@user.id}"

    fill_in 'Nome', with: 'FooBar'
    fill_in 'Nome de usuário', with: 'foobar'
    fill_in 'E-mail', with: 'foobar@foobar.com'
    fill_in 'Senha', with: 'foobar'
    fill_in 'Confirmar a senha', with: 'foobar'

    click_button 'Atualizar Usuário'

    expect(page).to have_content('Usuário atualizado com sucesso')
    expect(page).to have_current_path(user_path(@user, locale: 'pt-BR'))
  end

  scenario 'updates User with failure' do
    expect{
      visit users_path

      click_link "edit_user_#{@user.id}"

      fill_in 'Name', with: ''
      fill_in 'Username', with: 'foobar'
      fill_in 'E-mail', with: 'foobar@foobar.com'
      fill_in 'Password', with: 'foo'
      fill_in 'Password confirmation', with: 'foo'

      click_button 'Update User'

      expect(page).to have_content('Password is too short (minimum is 5 characters)')
    }.not_to change(@user, :name)
  end
end
