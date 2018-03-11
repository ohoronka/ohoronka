class CreateMobileDevices < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :mobile_devices, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps

      t.belongs_to :user, foreign_key: true, null: false, type: :uuid
      t.string :token
    end
  end
end
