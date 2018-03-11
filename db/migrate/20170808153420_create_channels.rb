class CreateChannels < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :channels, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps

      t.belongs_to :user, foreign_key: true, null: false, type: :uuid
      t.string :type, null: false
      t.string :auth_token
      t.string :identifier
      t.boolean :active, default: false, null: false
    end
  end
end
