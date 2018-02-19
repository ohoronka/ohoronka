class CreateOrderProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :order_products do |t|
      t.timestamps

      t.belongs_to :order, foreign_key: true, null: false
      t.belongs_to :product, foreign_key: true, null: false

      t.decimal :price, precision: 8, scale: 2, null: false, default: 0.0
      t.integer :quantity, default: 1, null: false
    end
  end
end
