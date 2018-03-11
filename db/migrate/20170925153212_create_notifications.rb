class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :notifications, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps

      t.belongs_to :user, foreign_key: true, null: false, type: :uuid
      t.belongs_to :target, polymorphic: true, type: :uuid
      t.belongs_to :source, polymorphic: true, type: :uuid

      t.integer :event, default: 0, limit: 1
      t.boolean :unread, default: true
      t.string :options
    end
  end
end
