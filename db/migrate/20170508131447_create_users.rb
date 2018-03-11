class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :users, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps

      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.boolean :admin, default: false
      t.string :avatar
      t.string :auth_token
    end

    add_index :users, :email, unique: true
    add_index :users, :auth_token, unique: true
  end
end
