class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    session[:dashboard] = true
    @advertises = current_user.advertises.all()
    @logs = current_user.logs.limit(20)
  end

end
