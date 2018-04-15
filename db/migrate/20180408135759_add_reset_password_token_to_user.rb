class AddResetPasswordTokenToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_reset_token, :string
    add_column :users, :password_reset_token_expires_at, :datetime
    add_index :users, :password_reset_token, unique: true
  end
end
