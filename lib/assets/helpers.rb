module AssetsHelper
  def base_width
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ",Rails.application.config.ad_unit_size
    Rails.application.config.ad_unit_size
  end
end
