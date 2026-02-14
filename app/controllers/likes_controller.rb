class LikesController < ApplicationController
  before_action :set_likeable

  def create
    if @likeable.likes.create(user: current_user)
      increment_likes
      redirect_to posts_path
    else
      destroy
    end
  end

  def destroy
    like = @likeable.likes.find_by(user: current_user)
    like.destroy

    decrement_likes

    redirect_to posts_path
  end

  private

  def set_likeable
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
  end

  def increment_likes
    @likeable.with_lock do |likeable|
      likeable.reload
      likeable.increment!(:likes)
    end
  end

  def decrement_likes
    @likeable.with_lock do |likeable|
      likeable.reload
      likeable.decrement!(:likes)
    end
  end
end
