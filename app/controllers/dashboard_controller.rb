class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    session[:dashboard] = true
    @advertises = current_user.advertises.order("updated_at")
    @logs = current_user.logs.order("created_at DESC").limit(20)
  end

end
