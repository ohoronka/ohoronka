class CreateFacilities < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :facilities, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps

      t.string :name
      t.integer :status, null: false, default: Facility.statuses[:idle], limit: 1
    end
  end
end
