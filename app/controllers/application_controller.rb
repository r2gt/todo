class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  before_action :set_locale, :authorize

  def default_url_options
    { locale: I18n.locale }
  end

  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
  end

  def logged_in?
    !!current_user
  end

  def current_user_admin?
    !!current_user&.admin?
  end

  private

  def authorize
    redirect_to login_path(params[:locale]), alert: t('sessions.new.not_authorized') unless logged_in?
  end

  def extract_locale
    params[:locale] if I18n.available_locales.map(&:to_s).include?(params[:locale])
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end
end
