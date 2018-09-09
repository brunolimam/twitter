class CreateTableBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|
      t.belongs_to :user
      t.belongs_to :blocked_user

      t.index [:user_id, :blocked_user_id], unique: true
    end
  end
end
