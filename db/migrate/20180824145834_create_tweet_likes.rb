class CreateTweetLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.belongs_to :user
      t.belongs_to :tweet
      t.index

      t.timestamps
    end
  end
end
