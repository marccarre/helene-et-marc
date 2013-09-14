class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  def set_locale
  	user_saved = session[:locale].presence
    user_preferred = http_accept_language.user_preferred_languages.presence
    user_compatible = http_accept_language.compatible_language_from(I18n.available_locales).presence
    I18n.locale = user_saved || user_compatible || I18n.default_locale
    logger.info("Resolving locale: available: [%s], default: [%s], user preferred: [%s], user compatible: [%s], saved: [%s] => selected: [%s]." % [I18n.available_locales.join(","), I18n.default_locale, user_preferred.present? ? user_preferred.join(",") : "none", user_compatible || "none", session[:locale] || "none", I18n.locale])
  end
end
