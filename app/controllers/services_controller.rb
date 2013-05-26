class ServicesController < ApplicationController

  def index
    @services = current_user.services if current_user
  end

  def create

    # get the full hash from omniauth
    oauth = request.env["omniauth.auth"]
    service = Service.find_by_provider_and_uid(oauth["provider"], oauth["uid"])

    # TODO: fill users information based on result of oauth transaction.
    # NOTE: Each service has its own result structure
    oauth["info"]["name"] ? name = oauth["info"]["name"] : name = ""
    oauth["info"]["email"] ? email = oauth["info"]["email"] : email = ""
    oauth["info"]["first_name"] ? first_name = oauth["info"]["first_name"] : first_name = ""
    oauth["info"]["last_name"] ? last_name = oauth["info"]["last_name"] : last_name = ""

    if service
      # Service are already registered for user
      logger.debug("Logging in the user using exists service data.")
      flash[:info] = "You successfully logged in."
      sign_in_and_redirect :user, service.user

    elsif current_user
      # user is logged in but does not have this service registered
      logger.debug("User already logged in. Storing service data to database.")
      current_user.services.create!(provider: oauth["provider"],
                                    uid: oauth["uid"])
      flash[:info] = "You authenticated successfully.\n"
      redirect_to services_url

    else
      logger.info("Create new user based on oauth data")
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
