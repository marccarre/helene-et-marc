class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  private
    def set_locale
      if (params[:locale])
        set_locale_from_params
      end
    	user_saved = session[:locale].presence
      user_preferred = http_accept_language.user_preferred_languages.presence
      user_compatible = http_accept_language.compatible_language_from(I18n.available_locales).presence
      I18n.locale = user_saved || user_compatible || I18n.default_locale
      logger.info("Resolving locale: available: [%s], default: [%s], user preferred: [%s], user compatible: [%s], saved: [%s] => selected: [%s]." % [I18n.available_locales.join(","), I18n.default_locale, user_preferred.present? ? user_preferred.join(",") : "none", user_compatible || "none", session[:locale] || "none", I18n.locale])
    end

    def set_locale_from_params
      if (I18n.available_locales.include? params[:locale].to_sym)
        new_locale = params[:locale]
        old_locale = session[:locale]
        session[:locale] = new_locale || old_locale
        logger.info("Locale saved for user: old: [%s], new: [%s] => current: [%s]." % [old_locale || "", new_locale || "", session[:locale] || ""])
      else
        session.delete(:locale)
        logger.info("[%s]'s locale has been removed from session." % [request.remote_ip])
        flash.now[:notice] = "#{params[:locale]} translation not available."
        logger.error("Invalid locale trying to be set by %s: [%s]." % [request.remote_ip, params[:locale]])
      end
    end
end
