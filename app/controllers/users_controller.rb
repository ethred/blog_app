class UsersController < ApplicationController
  layout 'standard'
  before_action :authenticate_user!, except: [:index]
  def index
    @users = User.includes(posts: :comments).order(id: :asc)
  end

  # def show
  #   if params[:id] == 'sign_up'
  #     # Handle the case where the parameter is 'sign_up'
  #     # This could be a special case for showing a signup page or redirecting to the signup page.
  #     # Adjust this part based on your application's requirements.
  #     redirect_to new_user_registration_path
  #   else
  #     # Assume the parameter is a numerical ID
  #     @user = User.includes(posts: :comments).find(params[:id])
  #     @recent_posts = @user.recent_posts
  #   end
  # end
  def show
    @user = User.find(params[:id])
  end

  def sign_out_user
    sign_out(current_user)
    redirect_to root_path, notice: 'Signed out successfully'
  end
end
