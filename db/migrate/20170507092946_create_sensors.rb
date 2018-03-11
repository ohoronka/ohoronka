class CreateSensors < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :sensors, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps

      t.belongs_to :device, foreign_key: true, null: false, type: :uuid

      t.string :name

      t.integer :status, null: false, default: Sensor.statuses[:offline], limit: 1

      t.integer :gpio_listen, null: false, default: 0
      t.integer :gpio_ok, null: false, default: 0
    end
  end
end
