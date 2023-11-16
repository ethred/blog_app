class CommentsController < ApplicationController
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
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully deleted.'
    else
      redirect_to user_post_path(@user, @post), alert: 'Failed to delete comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
