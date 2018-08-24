class AddCompositePrimaryKeyToLikes < ActiveRecord::Migration[5.2]
  def change
    add_index :likes, [:user_id, :tweet_id], unique: true
  end
end
