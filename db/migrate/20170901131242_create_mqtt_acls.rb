class CreateMqttAcls < ActiveRecord::Migration[5.1]
  def change
    create_table :mqtt_acls do |t|
      t.timestamps
      t.belongs_to :mqtt_user, foreign_key: true
      t.string :user_name
      t.string :topic
      t.integer :rw, default: 0
    end

    add_index :mqtt_acls, [:user_name, :topic], unique: true
  end
end
