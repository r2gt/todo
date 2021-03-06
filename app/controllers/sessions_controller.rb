class SessionsController < ApplicationController
  skip_before_action :authorize, only: %i(new create)

  def new
  end

  def create
    user = User.find_by_username_or_email(params.dig(:session, :username_or_email))

    if user and user.authenticate(params.dig(:session, :password))
      session[:current_user_id] = user.id
      redirect_to locale_root_path, notice: t('.success')
    else
      flash.now[:alert] = t('.alert')
      render :new
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to login_path, notice: t('.success')
  end
end
