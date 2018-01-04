class CreateMobileDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :mobile_devices do |t|
      t.timestamps

      t.belongs_to :user, foreign_key: true
      t.string :token
    end
  end
end
