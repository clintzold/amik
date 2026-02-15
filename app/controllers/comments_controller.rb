class CommentsController < ApplicationController
  def index
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to posts_path
    else
      redirect_to posts_path, status: :unprocessable_content
    end
  end

  def show
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end
end
