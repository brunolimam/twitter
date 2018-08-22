class FollowingRelation < ApplicationRecord
  belongs_to :user, as: :follower
  belongs_to
end
