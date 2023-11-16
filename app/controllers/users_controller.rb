class UsersController < ApplicationController
  layout 'standard'
  before_action :authenticate_user!, except: %i[index show]

  def index
    @users = User.includes(posts: :comments).order(id: :asc)
  end

  def show
    @user = User.find(params[:id])
  end

  def sign_out_user
    sign_out(current_user)
    redirect_to root_path, notice: 'Signed out successfully'
  end
end
