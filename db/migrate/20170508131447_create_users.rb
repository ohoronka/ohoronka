class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.belongs_to :account
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
