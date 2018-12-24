require 'rails_helper'

feature 'Creating an user' do
  background do
    sign_in
  end

  scenario 'Create user, using English locale' do
    visit users_path(locale: 'en')

    expect {
      click_link('New User')

      fill_in('Name', with: 'Admin')
      fill_in('Username', with: 'Admin')
      fill_in('E-mail', with: 'admin@admin.com')
      fill_in('Password', with: '123456')
      fill_in('Password confirmation', with: '123456')

      click_button('Create User')

      expect(page).to have_text 'User was successfully created'
      expect(page).to have_current_path users_path(locale: 'en')
    }.to change(User, :count).from(1).to(2)
  end

  scenario 'Create user, using portuguese locale' do
    visit users_path(locale: 'pt-BR')

    expect {
      click_link('Novo Usuário')

      fill_in('Nome', with: 'Admin')
      fill_in('Nome de usuário', with: 'Admin')
      fill_in('E-mail', with: 'admin@admin.com')
      fill_in('Senha', with: '123456')
      fill_in('Confirmar a senha', with: '123456')

      click_button('Criar Usuário')

      expect(page).to have_text 'Usuario criado com sucesso'
      expect(page).to have_current_path users_path(locale: 'pt-BR')
    }.to change(User, :count).from(1).to(2)
  end
end
