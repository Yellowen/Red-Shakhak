class RegistrationsController < Devise::RegistrationsController

  def create
    # Q: Why did we don't use super here?
    # A: Using super lead to an odd exception
    #    which is about bad value in self.resource
    #    It should contains a User instance. but to has
    #    True value

    # This code snippet borrowed from Devise --------------------
    build_resource(sign_up_params)

    resource.role = 1 if resource.role == 0

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
    # -----------------------------------------------------------
    session[:oauth] = nil unless @user.new_record?

  end

  private

  def build_resource(*args)
    super

    # Create the user service from oauth data in session.
    if session[:oauth]
      # Role = 1 is the normal user
      session[:oauth].update({:role => 1})
      @user.create_from_oauth(session[:oauth])
      @user.valid?
    end

  end
end
