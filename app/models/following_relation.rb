class FollowingRelation < ApplicationRecord
  belongs_to :user, touch: true, counter_cache: true
  belongs_to :followed_user, counter_cache: :followers_count, class_name: "User"

  validate :self_follow

  private

  def self_follow
    return unless user_id == followed_user_id
    errors.add :user, 'Um usuário não pode seguir a si mesmo'
  end
end
