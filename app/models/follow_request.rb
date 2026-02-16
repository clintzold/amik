class FollowRequest < ApplicationRecord
  belongs_to :requester
  belongs_to :requestee
end
