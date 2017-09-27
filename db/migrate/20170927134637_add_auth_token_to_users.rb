class AddAuthTokenToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :auth_token, :string
    User.find_each do |user|
      user.send :generate_auth_token
      user.save
    end
    add_index :users, :auth_token, unique: true
  end

  def down
    remove_column :users, :auth_token
  end
end
