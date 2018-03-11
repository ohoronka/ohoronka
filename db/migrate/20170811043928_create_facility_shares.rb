class CreateFacilityShares < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :facility_shares, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps

      t.belongs_to :user, foreign_key: true, null: false, type: :uuid
      t.belongs_to :facility, foreign_key: true, null: false, type: :uuid
      t.integer :role, default: 0, limit: 1

    end

    add_index :facility_shares, [:user_id, :facility_id], unique: true
  end
end
