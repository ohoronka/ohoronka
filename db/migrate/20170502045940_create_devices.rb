class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.timestamps
      t.datetime :pinged_at

      t.belongs_to :object

      t.string :name
      t.integer :gpio_listen, null: false, default: 0
      t.integer :gpio_pull, null: false, default: 0
      t.integer :gpio_ok, null: false, default: 0
    end
  end
end
