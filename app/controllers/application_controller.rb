class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  def set_locale
    user_preferred = http_accept_language.user_preferred_languages
    user_compatible = http_accept_language.compatible_language_from(I18n.available_locales)
    session[:locale] = params[:locale] || session[:locale]
    I18n.locale = session[:locale] || user_compatible || user_preferred.first || I18n.default_locale
    logger.info("Locales: available: [%s], default: [%s], user preferred: [%s], user compatible: [%s], requested: [%s], saved: [%s] => selected: [%s]." % [I18n.available_locales.join(","), I18n.default_locale, user_preferred.join(","), user_compatible, params[:locale] || "", session[:locale] || "", I18n.locale])
  end
end
