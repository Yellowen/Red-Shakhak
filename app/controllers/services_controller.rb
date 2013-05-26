class ServicesController < ApplicationController

  def index
    @services = current_user.services if current_user
  end

  def create

    # get the full hash from omniauth
    oauth = request.env["omniauth.auth"]
    service = Service.find_by_provider_and_uid(oauth["provider"], oauth["uid"])

    if service
      # Service are already registered for user
      flash[:info] = "You successfully logged in."
      sign_in_and_redirect :user, service.user

    elsif current_user
      # user is logged in but does not have this service registered
      current_user.services.create!(provider: oauth["provider"],
                                    uid: oauth["uid"])
      flash[:info] = "You authenticated successfully.\n"
      redirect_to services_url

    else
      user = User.new
      user.create_from_oauth(oauth)
      if user.save
        flash[:notice] = ""
        sign_in_and_redirect :user, user

      else
        session[:oauth] = oauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  def destroy
    @servoce = current_user.services.find(params[:id])
    @service.destroy
    flash[:notice] = "Service removed successfully"

    redirect_to services_url
  end

end
