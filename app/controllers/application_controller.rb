class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def extract_locale
    params[:locale] if I18n.available_locales.map(&:to_s).include?(params[:locale])
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end
end
