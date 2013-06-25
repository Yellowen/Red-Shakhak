require "date"

class HomeController < ApplicationController
  layout "application"

  def index
    @advertises = Advertise.where("deactive_date >= ?", DateTime.now).order("cost_per_day DESC").limit(config.first_page_advertises)
  end

end
