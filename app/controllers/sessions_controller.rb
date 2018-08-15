class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username_or_email(params.dig(:session, :username_or_email))

    if user and user.authenticate(params.dig(:session, :password))
      session[:current_user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully.'
    else
      flash.now[:alert] = 'Wrong email or password.'
      render :new
    end
  end
end
