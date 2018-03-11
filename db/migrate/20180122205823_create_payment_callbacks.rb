class CreatePaymentCallbacks < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :payment_callbacks, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps
      t.belongs_to :order, foreign_key: true, null: false, type: :uuid
      t.string :status
      t.json :options
    end
  end
end
