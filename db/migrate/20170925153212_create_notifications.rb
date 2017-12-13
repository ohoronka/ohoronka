class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.timestamps

      t.belongs_to :user, foreign_key: true
      t.belongs_to :target, polymorphic: true
      t.integer :event, default: 0, limit: 1
      t.boolean :unread, default: true
      t.string :params
    end
  end
end
