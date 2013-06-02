class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    session[:dashboard] = true
    @advertises = current_user.advertises.all()
  end

end
