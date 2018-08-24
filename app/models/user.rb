class User < ApplicationRecord
  validates :user_name, uniqueness: true

  has_one_attached :avatar

  has_many :following_relations, dependent: :destroy
  has_many :followed_users, through: :following_relations

  has_many :followers, foreign_key: :followed_user_id, class_name: 'FollowingRelation', dependent: :destroy
  has_many :follower_users, through: :followers, source: :user

  has_many :tweets, dependent: :destroy
  has_many :tweet_likes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
