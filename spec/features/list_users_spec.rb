require "rails_helper"

feature 'Listing all users' do
  background do
    @users = User.create(
      [
        { name: 'Foo', username: 'Bar', email: 'foo@bar.com', password: '12345' },
        { name: 'Fooza', username: 'foozafoo', email: 'fooza@bar.com', password: '12345' }
      ]
    )
  end

  scenario 'Displaying all users details, with English locale' do
    visit users_path

    expect(page).to have_text('Name: Foo')
    expect(page).to have_text('Username: Bar')
    expect(page).to have_text('Email: foo@bar.com')

    expect(page).to have_text('Name: Fooza')
    expect(page).to have_text('Username: foozafoo')
    expect(page).to have_text('Email: fooza@bar.com')
  end

  scenario 'Displaying all users details, with Brazilian portuguese locale' do
    visit users_path(locale: 'pt-BR')

    expect(page).to have_text('Nome: Foo')
    expect(page).to have_text('Nome de usuário: Bar')
    expect(page).to have_text('E-mail: foo@bar.com')

    expect(page).to have_text('Nome: Fooza')
    expect(page).to have_text('Nome de usuário: foozafoo')
    expect(page).to have_text('E-mail: fooza@bar.com')
  end
end
