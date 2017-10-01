class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :target, polymorphic: true
      t.integer :event, default: 0
      t.boolean :unread, default: true
      t.string :params

      t.timestamps
    end
  end
end