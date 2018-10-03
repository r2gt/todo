module FeatureMacros
  def sign_in
    @user = User.create(
      name: 'admin', username: 'admin', email: 'email@email.com',
      password: '12345', password_confirmation: '12345', admin:true
    )

    page.set_rack_session(current_user_id: @user.id)
  end
end
