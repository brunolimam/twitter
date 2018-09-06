class AvatarValidator < ActiveModel::Validator
  def validate(record)
    unless record.avatar.attached?
      record.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-avatar.png')), filename: 'default-avatar.png')
    end
  end
end

class User < ApplicationRecord
  include ActiveModel::Validations
  validates_with AvatarValidator

  validates :user_name, uniqueness: true

  has_one_attached :avatar

  has_many :following_relations, dependent: :destroy
  has_many :followed_users, through: :following_relations

  has_many :followers, foreign_key: :followed_user_id, class_name: 'FollowingRelation', dependent: :destroy
  has_many :follower_users, through: :followers, source: :user

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :mentions, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
