require "rails_helper"

feature 'Logging in an user' do
  background do
    @user = User.create(
      name: 'Teste', username: 'teste', email: 'foo@bar.com', password: 'teste'
    )
  end

  scenario 'Logging in successfully by email and redirecting to root' do
    visit login_path

    fill_in 'Username or email', with: 'foo@bar.com'
    fill_in 'Password', with: 'teste'

    click_button 'Login'

    expect(page).to have_text('Logged in successfully.')
    expect(page).to have_current_path(locale_root_path(locale: 'en'))
  end

  scenario 'Trying to login with wrong password and returning to login page' do
    visit login_path

    fill_in 'Username or email', with: 'foo@bar.com'
    fill_in 'Password', with: 'foozafoo'

    click_button 'Login'

    expect(page).to have_text('Wrong email or password.')
    expect(page).to have_current_path(create_session_path(locale: 'en'))
  end

  scenario 'Not finding user by email and returning to login page' do
    visit login_path

    fill_in 'Username or email', with: 'fooza@bar.com'
    fill_in 'Password', with: 'teste'

    click_button 'Login'

    expect(page).to have_text('Wrong email or password.')
    expect(page).to have_current_path(create_session_path(locale: 'en'))
  end

  scenario 'Logging in successfully by username and redirecting to root' do
    visit login_path

    fill_in 'Username or email', with: 'teste'
    fill_in 'Password', with: 'teste'

    click_button 'Login'

    expect(page).to have_text('Logged in successfully.')
    expect(page).to have_current_path(locale_root_path(locale: 'en'))
  end

  scenario 'Logging out successfully and redirecting to login page' do
    visit login_path

    
    fill_in 'Username or email', with: 'teste'
    fill_in 'Password', with: 'teste'
    
    click_button 'Login'
    click_link 'Logout'
    
    expect(page).to have_text('Logged out successfully.')
    expect(page).to have_current_path(login_path(locale: 'en'))
    expect(page).not_to have_text('Logout')
  end
end
