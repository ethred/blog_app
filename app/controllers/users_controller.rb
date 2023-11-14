class UsersController < ApplicationController
  layout 'standard'
  def index
    # @users = User.order(id: :asc)
    @users = User.includes(posts: :comments).order(id: :asc)
  end

  def show
    # @user = User.find(params[:id]) # find user by id
    # @recent_posts = @user.recent_posts
    @user = User.includes(posts: :comments).find(params[:id])
    @recent_posts = @user.recent_posts
  end
end
