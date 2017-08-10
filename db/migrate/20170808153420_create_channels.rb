class CreateChannels < ActiveRecord::Migration[5.1]
  def change
    create_table :channels do |t|
      t.timestamps

      t.belongs_to :user, foreign_key: true
      t.string :type
      t.string :auth_token
      t.string :identifier
      t.boolean :activated, default: false
    end
  end
end
