class FollowsController < ApplicationController
  def index
    @requests = Follow.where(followed_id: current_user.id, accepted: false).order(:desc)
    @followers = Follow.where(followed_id: current_user.id).order(accepted: :asc)
    @following = Follow.where(follower_id: current_user.id).order(accepted: :asc)
  end

  def create
    @user = User.find(params[:id])
    current_user.follow(@user)

    redirect_to profile_path(@user)
  end

  def deny
    @user = User.find(params[:id])
    current_user.remove_follower(@user)

    redirect_to profile_path(@user), notice: "Follow request denied:" + @user.first_name + " " + @user.last_name
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user)

    redirect_to profile_path(@user), notice: "Unfollowed " + @user.first_name + " " + @user.last_name
  end

  def accept
    @follow = Follow.find(params[:id])
    @follow.update(accepted: true)
    redirect_to profile_path(@follow.follower), notice: "Follow request accepted."
  end
end
