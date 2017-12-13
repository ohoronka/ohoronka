class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.timestamps

      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :admin, default: false
    end
  end
end
