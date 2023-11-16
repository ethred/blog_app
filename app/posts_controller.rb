class PostsController < ApplicationController
  before_action :authorize_delete, only: :destroy

  def index
    @user = User.find_by_id(params[:user_id])
    @posts = @user.posts.includes(:comments, :likes).paginate(page: params[:page], per_page: 10)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
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

  private

  def authorize_delete
    @post = Post.find(params[:id])
    @user = @post.author # Set @user to the author of the post
    authorize! :destroy, @post
  end
end
