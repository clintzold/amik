class FollowsController < ApplicationController
  def index
    @follows = Follow.where(followed_id: current_user.id).order(accepted: :asc)
    @following = Follow.where(follower_id: current_user.id).order(accepted: :asc)
  end

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)

    redirect_to @user
  end

  def destroy
    current_user.unfollow(params[:followed_id])
    redirect_to @user
  end

  def accept
    @follow = Follow.find(params[:id])
    @follow.update(accepted: true)
    redirect_to profile_path(@follow.follower), notice: "Follow request accepted."
  end
end
