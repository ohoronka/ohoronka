class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.timestamps
      t.string :name, null: false
      t.string :description
      t.string :image
      t.decimal :price, precision: 8, scale: 2, null: false, default: 0.0
      t.integer :stock, null: false, default: 0
    end
  end
end
