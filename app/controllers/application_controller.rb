class ApplicationController < ActionController::Base
  before_filter :set_gettext_locale

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def target_url

    if session[:dashboard]
      session.delete(:dashboard)
      return dashboard_index_url
    end
    return nil

  end

  def not_found
    raise ActionController::RoutingError.new(t(:not_found))
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

end
