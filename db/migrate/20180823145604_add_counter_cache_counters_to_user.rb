class AddCounterCacheCountersToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :following_relations_count, :integer
    add_column :users, :followers_count, :integer
  end
end
