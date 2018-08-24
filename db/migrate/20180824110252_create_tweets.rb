class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.belongs_to :user, index: true
      t.text :content, limit: 180

      t.timestamps
    end
  end
end
