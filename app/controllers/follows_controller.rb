class FollowsController < ApplicationController
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
    redirect_to user_path(current_user), notice: "Follow request accepted."
  end
end
