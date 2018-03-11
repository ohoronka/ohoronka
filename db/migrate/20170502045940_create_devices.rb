class CreateDevices < ActiveRecord::Migration[5.1]
  def up
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    execute "CREATE SEQUENCE device_number_seq START 1;"

    create_table :devices, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps
      t.datetime :pinged_at
      t.integer :number, null: false, default: -> { "nextval('device_number_seq')" }
      t.belongs_to :facility, foreign_key: true, null: false, type: :uuid
      t.string :name
      t.integer :status, null: false, default: Device.statuses[:offline], limit: 1
      t.integer :gpio_listen, null: false, default: 0
    end

    execute("ALTER SEQUENCE device_number_seq OWNED BY devices.number;")
    add_index :devices, :number, unique: true
  end

  def down
    drop_table :devices
    execute("DROP SEQUENCE device_number_seq")
  end
end
