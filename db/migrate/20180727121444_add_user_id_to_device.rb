class AddUserIdToDevice < ActiveRecord::Migration[5.1]
  def up
    add_column :devices, :fw_version, :integer, default: 0
    add_column :devices, :user_id, :uuid, null: true, after: :facility_id
    add_foreign_key :devices, :users
    change_column_null(:devices, :facility_id, true)

    Device.all.each do |device|
      device.user_id = device.facility.shares.where(role: :owner).take.user_id
    end
  end

  def down
    remove_column :devices, :user_id
    remove_column :devices, :fw_version
  end
end
