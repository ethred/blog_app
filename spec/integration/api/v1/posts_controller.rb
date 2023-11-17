# app/controllers/api/v1/posts_controller.rb
class Api::V1::PostsController < ApplicationController
  layout 'standard'
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, notice: 'Access Denied!'
  end

  def index
    @user = User.includes(:posts).find(params[:user_id])
    @posts = Post.where(author: @user)
    render json: @posts, status: :ok, only: %i[id author_id title text]
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    render json: @comments, status: :ok, only: %i[id author_id post_id text]
  end
end
