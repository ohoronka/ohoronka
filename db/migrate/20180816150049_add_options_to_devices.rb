class AddOptionsToDevices < ActiveRecord::Migration[5.1]
  def up
    add_column :devices, :options, :json, default: {}
    Device.all.find_each do |device|
      device.send :set_options
      device.save
    end
  end

  def down
    remove_column :devices, :options
  end
end
