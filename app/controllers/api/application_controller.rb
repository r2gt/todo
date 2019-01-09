class API::ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate

  private

  def authenticate
    authenticate_with_http_token do |token, options|
      @current_user ||= User.find_by(api_token: token)
    end || head(:unauthorized)
  end
end