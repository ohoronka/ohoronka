class CreateFriendShips < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.timestamps

      t.belongs_to :user, foreign_key: true
      t.belongs_to :friend
      t.integer :status, default: 0
    end

    add_index :friendships, [:user_id, :friend_id], unique: true
  end
end
