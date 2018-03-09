class RemoveFriendship < ActiveRecord::Migration[5.1]
  def up
    drop_table :friendships
    Notification.where(event: [:friendship_request, :accepted_friendship])
  end

  def down
    raise "Migration can't be reverted"
  end
end
