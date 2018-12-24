require "rails_helper"

feature 'Displaying an user' do
  background do
    sign_in

    @user = User.create(
      name: 'Foo', username: 'Bar', email: 'foo@teste.com.br',
      password: '12345'
    )
  end

  scenario 'Displays all details from user, with English locale' do
    visit user_path(@user, locale: 'en')

    expect(page).to have_text('Name: Foo')
    expect(page).to have_text('Username: Bar')
    expect(page).to have_text('Email: foo@teste.com.br')
  end

  scenario 'Displays all details from user, with Brazilian portuguese locale' do
    visit user_path(@user, locale: 'pt-BR')

    expect(page).to have_text('Nome: Foo')
    expect(page).to have_text('Nome de usuário: Bar')
    expect(page).to have_text('E-mail: foo@teste.com.br')
  end
end
