class ApplicationController < ActionController::Base
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

end
