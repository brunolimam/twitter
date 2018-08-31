class Tweet < ApplicationRecord
  validates :content, length: { maximum: 180 }
  attr_accessor :liked
  
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :mentions, dependent: :destroy
end
