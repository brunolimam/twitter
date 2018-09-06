class MentionsValidator < ActiveModel::Validator
  def validate(record)
    @mentions = record.content.scan(/[@][a-zA-Z1-9]*/)
    @actual_mentions = @mentions.collect! { |mention|
      mention[1,mention.length]
    }
    @mentioned_users = User.where(user_name: @actual_mentions)
    @mentioned_users.each do |mentioned_user|
      @mention = Mention.new(user_id: mentioned_user.id)
      record.mentions << @mention
      TweetMentionMailer.with(user: mentioned_user, mention: @mention).notify_mentioned_user.deliver_later
    end
  end
end

class Tweet < ApplicationRecord
  validates :content, length: { maximum: 180 }
  validates_with MentionsValidator
  
  attr_accessor :liked
  
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :mentions, dependent: :destroy
end
