class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.timestamps
      t.datetime :pinged_at

      t.belongs_to :facility

      t.string :name

      t.integer :status, null: false, default: Device.statuses[:offline], limit: 1


      t.integer :gpio_listen, null: false, default: 0
      t.integer :gpio_pull, null: false, default: 0
      t.integer :gpio_ok, null: false, default: 0
    end
  end
end
