module FeatureMacros
  def sign_in
    create_user
    page.set_rack_session(current_user_id: @user.id)
  end

  def sign_in_with_board
    create_user
    create_board
    page.set_rack_session(current_user_id: @user.id)
  end

  def create_user
    @user = User.create(
      name: 'admin', username: 'admin', email: 'email@email.com',
      password: '12345', password_confirmation: '12345', admin:true
    )
  end

  def create_board
    @board = @user.boards.create(name: 'Board 1')
  end

  def create_todo
    @todo_item = @board.todo_items.create(description: 'Todo item 1', user: @user)
  end
end
