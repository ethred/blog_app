class UsersController < ApplicationController
  layout 'standard'
  def index
    @users = User.includes(posts: :comments).order(id: :asc)
  end

  def show
    @user = User.includes(posts: :comments).find(params[:id])
    @recent_posts = @user.recent_posts
  end
end
