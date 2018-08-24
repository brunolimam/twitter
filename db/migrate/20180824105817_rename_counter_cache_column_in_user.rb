class RenameCounterCacheColumnInUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :following_relations_count, :followees_count
  end
end
