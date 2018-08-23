class User < ApplicationRecord
  has_one_attached :avatar

  has_many :following_relations
  has_many :followed_users, through: :following_relations

  has_many :followers, foreign_key: :followed_user_id, class_name: 'FollowingRelation'
  has_many :follower_users, through: :followers, source: :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
