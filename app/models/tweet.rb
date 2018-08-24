class Tweet < ApplicationRecord
  validates :content, length: { maximum: 180 }
  belongs_to :user
  has_many :likes, dependent: :destroy
end
