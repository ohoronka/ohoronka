class AddAvatarToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :name, :first_name
    add_column :users, :last_name, :string, after: :first_name
    add_column :users, :about, :text
    add_column :users, :avatar, :string
    add_column :users, :background, :string
  end
end
