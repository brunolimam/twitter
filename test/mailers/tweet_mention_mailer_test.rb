require 'test_helper'

class TweetMentionMailerTest < ActionMailer::TestCase
  test "tweet_mention" do
    email = TweetMentionMailer.create_tweet_mention('me@example.com', 'mentioned_user@example.com', Time.now)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['me@example.com'], email.from
    assert_equal ['mentioned_user@example.com'], email.tweet_mention
    assert_equal 'Hey, you have just been mentioned!', email.subject
    assert_equal read_fixture('tweet_mention').join, email.body.to_s
  end
end
