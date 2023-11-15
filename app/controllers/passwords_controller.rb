class PasswordsController < Devise::PasswordsController
  # ... other actions ...

  def successfully_updated_password(resource)
    if resource.update_with_password(password_params)
      resource.unlock_access! if unlockable?(resource)
      sign_in(resource, scope: resource_name, bypass: true)
      Rails.logger.info("User successfully updated password and signed in: #{resource.email}")
      true
    else
      Rails.logger.error("Failed to update password for user: #{resource.email}")
      Rails.logger.error("Errors: #{resource.errors.full_messages}")
      false
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      if successfully_updated_password(resource)
        set_flash_message!(:notice, :updated)
        respond_with resource, location: after_resetting_password_path_for(resource)
      else
        respond_with resource
      end
    else
      respond_with resource
    end
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
