class ApplicationController < ActionController::Base
  before_action :set_locale

  private
  
  def set_locale
    if params[:locale]
      cookies[:locale] = params[:locale]
      I18n.locale = params[:locale]
    else
      cookies_locale = cookies[:locale]
      I18n.locale = cookies_locale if cookies_locale.present?
    end
  end
end