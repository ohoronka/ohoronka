class CreateMqttUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :mqtt_users do |t|
      t.timestamps

      t.belongs_to :device
      t.string :user_name
      t.string :password
      t.string :password_hash
    end

    add_index :mqtt_users, :user_name, unique: true
  end
end
