require "date"

class HomeController < ApplicationController
  layout "application"

  def index
    @advertises = Advertise.where("deactive_date >= ?", DateTime.now).order("cost_per_day DESC").page(params[:page]).per(25)
    respond_to do |format|
      format.html {}
      format.json { render :json => @advertises }
    end
  end

  def advertises
    @advertises = Advertise.where("deactive_date >= ?", DateTime.now).order("cost_per_day DESC").page(params[:page]).per(25)
    respond_to do |format|
      format.json
    end
  end
end
