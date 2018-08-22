class CreateFollowingRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :following_relations do |t|
      t.integer :following_id, null: false
      t.integer :follower_id, null: false

      t.timestamps
    end
  end
end
