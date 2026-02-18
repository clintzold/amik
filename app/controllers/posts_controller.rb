class PostsController < ApplicationController
  before_action :set_post, except: [:index, :create]

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
    if @post.update(post_params)
      redirect_to @post, notice: "New post created successfully!"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def show
    @new_comment = Comment.new
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :images)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
