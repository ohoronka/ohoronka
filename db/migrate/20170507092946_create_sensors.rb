class CreateSensors < ActiveRecord::Migration[5.1]
  def change
    create_table :sensors do |t|
      t.timestamps

      t.belongs_to :device

      t.string :name

      t.integer :status, null: false, default: Sensor.statuses[:offline], limit: 1

      t.integer :gpio_listen, null: false, default: 0
      t.integer :gpio_pull, null: false, default: 0
      t.integer :gpio_ok, null: false, default: 0
    end
  end
end
