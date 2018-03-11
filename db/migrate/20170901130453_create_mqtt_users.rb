class CreateMqttUsers < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :mqtt_users, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps

      t.belongs_to :device, foreign_key: true, null: false, type: :uuid
      t.string :user_name
      t.string :password
      t.string :password_hash
    end

    add_index :mqtt_users, :user_name, unique: true
  end
end
