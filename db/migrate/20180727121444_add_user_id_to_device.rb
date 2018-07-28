class AddUserIdToDevice < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :fw_version, :integer, default: 0
    add_column :devices, :user_id, :uuid, index: true, after: :facility_id
    change_column_null(:devices, :facility_id, true)
  end
end
