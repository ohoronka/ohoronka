class CreateOrders < ActiveRecord::Migration[5.1]
  def up
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    execute "CREATE SEQUENCE order_number_seq START 3118;"

    create_table :orders, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps
      t.belongs_to :user, foreign_key: true, null: false, type: :uuid
      t.integer :number, null: false, default: -> { "nextval('order_number_seq')" }
      t.integer :status, limit: 1, default: 0, null: false
      t.integer :delivery_method, limit: 1, default: 0, null: false
      t.integer :payment_method, limit: 1, default: 0, null: false
      t.decimal :total, precision: 8, scale: 2
      t.boolean :paid, default: false, null: false
      t.text :comment

      t.json :delivery_options
    end

    execute("ALTER SEQUENCE order_number_seq OWNED BY orders.number;")
    add_index :orders, :number, unique: true
  end

  def down
    drop_table :orders
    execute("DROP SEQUENCE order_number_seq")
  end
end
