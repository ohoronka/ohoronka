class CreateFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :facilities do |t|
      t.timestamps

      t.string :name
      t.integer :status, null: false, default: Facility.statuses[:idle], limit: 1
    end
  end
end
