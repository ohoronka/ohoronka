class CreateOrderProducts < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :order_products, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps

      t.belongs_to :order, foreign_key: true, null: false, type: :uuid
      t.belongs_to :product, foreign_key: true, null: false, type: :uuid

      t.decimal :price, precision: 8, scale: 2
      t.integer :quantity, default: 1, null: false
    end
  end
end
