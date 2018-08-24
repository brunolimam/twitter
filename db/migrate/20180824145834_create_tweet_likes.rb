class CreateTweetLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.belongs_to :user
      t.belongs_to :tweet
      t.integer :likes_count

      t.timestamps
    end
  end
end
