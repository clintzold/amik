class PostsController < ApplicationController
  def index
    @posts = Post.includes(:comments).all.order(created_at: :desc)
    @new_post = Post.new
    @new_comment = Comment.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :index, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
