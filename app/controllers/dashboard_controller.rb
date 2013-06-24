class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    session[:dashboard] = true
    @advertises = current_user.advertises.order("updated_at").page(params[:page])
    #@advertises = Advertise.where(user: current_user).order("updated_at").page(params[:page])
    @renew_records = current_user.renews.order("renew_date desc").limit(20)
    @logs = current_user.logs.order("created_at DESC").limit(20)
  end

end
