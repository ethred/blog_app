class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find_by_id(params[:user_id])
    @posts = @user.posts.includes(:comments) if @user
  end

  def show
    @user = User.find_by_id(params[:user_id])
    @post = Post.find_by_id(params[:id])
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.create(author: @user, title: params[:post][:title], text: params[:post][:text], comments_counter: 0,
                        likes_counter: 0)
    if @post.save
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    @user = User.find_by_id(params[:user_id])
    if @post.destroy
      @post.author.decrement!(:posts_counter)
      redirect_to user_posts_path(@user), notice: 'Post was successfully deleted.'
    else
      redirect_to user_posts_path(@user), alert: 'Error deleting post.'
    end
  end
end
