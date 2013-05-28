class HomeController < ApplicationController

  def index
    @advertises = Advertise.limit(config.first_page_advertises)
  end

end
