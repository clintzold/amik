class LikesController < ApplicationController
  before_action :set_likeable

  def toggle
    @likeable.likes.build(user: current_user)

    if @likeable.save
      increment_counter
    else
      destroy
    end

    redirect_to posts_path
  end


  private

  def set_likeable
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
  end

  def increment_counter
    @likeable.with_lock do 
      @likeable.increment!(:likes_counter)
    end
  end

  def destroy
    like = @likeable.likes.find_by(user: current_user)
    like.destroy

    @likeable.with_lock do
      @likeable.decrement!(:likes_counter)
    end
  end
end
