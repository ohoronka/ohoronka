class CreatePaymentCallbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_callbacks do |t|
      t.timestamps
      t.belongs_to :order, foreign_key: true
      t.string :status
      t.json :options
    end
  end
end
