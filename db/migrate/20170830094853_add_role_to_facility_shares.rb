class AddRoleToFacilityShares < ActiveRecord::Migration[5.1]
  def change
    add_column :facility_shares, :role, :integer, default: 0
    add_index :facility_shares, [:user_id, :facility_id], unique: true
  end
end
