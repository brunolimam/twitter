class AddLikesCountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :likes_count, :integer
  end
end
