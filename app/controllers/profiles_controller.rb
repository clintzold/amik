class ProfilesController < ApplicationController
  def show
    @user = User.includes(:avatar_attachment, :background_attachment).find(params[:id])
    @new_comment = Comment.new
  end

  def index
    excluded_profiles = current_user.following.map(&:id)
    excluded_profiles << current_user.id
    @unfollowed = User.where.not(id: excluded_profiles)
    @followed = current_user.following
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path(@user)
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar, :background)
  end
end
