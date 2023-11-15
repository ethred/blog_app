# class ApplicationController < ActionController::Base
#   # def current_user
#   #   @current_user ||= User.includes(posts: %i[comments likes]).first
#   # end
# end
class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :bio, :photo, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :bio, :photo, :password, :current_password)
    end
  end
end

# class ApplicationController < ActionController::Base
#   include CanCan::ControllerAdditions
#   protect_from_forgery with: :exception
#   before_action :authenticate_user!
#   before_action :configure_permitted_parameters, if: :devise_controller?

#   protected

#   def configure_permitted_parameters
#     devise_parameter_sanitizer.permit(:sign_up, keys: %i[name bio photo])
#     devise_parameter_sanitizer.permit(:account_update, keys: %i[name bio photo])
#   end

#   helper_method :current_user
# end
# letter_opener