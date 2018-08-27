class CreateMentions < ActiveRecord::Migration[5.2]
  def change
    create_table :mentions do |t|
      t.belongs_to :user
      t.belongs_to :tweet

      t.timestamps
    end

    remove_column :likes, :likes_count
  end
end
