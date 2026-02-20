class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :likeable, source_type: 'Post'

  # Images Associations
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100,100]
    attachable.variant :medium, resize_to_limit: [300,300]
  end
  has_one_attached :background
  has_many_attached :images
  # Outgoing follow request associations
  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :followed
  # Incoming follow request associations
  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :followed

  # Helper methods for requests
  def follow(other_user)
    active_follows.create(followed: other_user)
  end

  def unfollow(other_user)
    active_follows.find_by(followed: other_user).destroy
  end

  def remove_follower(other_user)
    passive_follows.find_by(follower: other_user).destroy
  end

  def pending_followers
    followers.where(follows: {accepted: false})
  end

  def following?(other_user)
    active_follows.where(followed: other_user).exists?
  end
end
