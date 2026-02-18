class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  # Allow posts to have images
  has_many_attached :images do |attachable|
    attachable.variant :preview, resize_to_limit: [400, 400]
  end
end
