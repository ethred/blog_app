class CommentsController < ApplicationController
  before_action :authorize_delete, only: :destroy

  def new
    @user = current_user
    @post = Post.includes(:author).find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.includes(:author).find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @user = @post.author

    if @comment.save
      redirect_to user_posts_path(@user), notice: 'Comment was successfully created.'
    else
      redirect_to user_posts_path(@user), alert: 'Error creating comment.'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to user_posts_path(current_user), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def authorize_delete
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
  end
end
