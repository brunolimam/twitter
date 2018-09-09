class Block < ApplicationRecord
  belongs_to :user, foreign_key: "blocked_user_id", counter_cache: :blocked_users_count

  validate :self_block

  private

  def self_block
    return unless user_id == blocked_user_id
    errors.add :user, "An user cannot block himself/herself"
  end
end
