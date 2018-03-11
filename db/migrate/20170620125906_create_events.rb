class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :events, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps

      t.belongs_to :target, polymorphic: true, type: :uuid, null: false
      t.belongs_to :facility, foreign_key: true, null: false, type: :uuid

      t.integer :target_status, null: false, default: 0, limit: 1
      t.integer :facility_status, null: false, default: 0, limit: 1

      t.boolean :dashboard, null: false, default: false
    end
  end
end
