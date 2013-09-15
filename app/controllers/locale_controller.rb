class LocaleController < ApplicationController
  skip_before_filter :set_locale, :except => [:set]
  
  def set
    new_locale = params[:locale]
    old_locale = session[:locale]
    session[:locale] = new_locale || old_locale
    logger.info("Locale saved for user: old: [%s], new: [%s] => current: [%s]." % [old_locale || "", new_locale || "", session[:locale] || ""])
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to :root
  end


end
