class CreateMqttAcls < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :mqtt_acls, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps
      t.belongs_to :mqtt_user, foreign_key: true, null: false, type: :uuid
      t.string :user_name
      t.string :topic
      t.integer :rw, default: 0
    end

    add_index :mqtt_acls, [:user_name, :topic], unique: true
  end
end
