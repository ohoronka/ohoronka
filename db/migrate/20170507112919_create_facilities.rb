class CreateFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :facilities do |t|
      t.timestamps

      t.belongs_to :account

      t.string :name
      t.integer :status, null: false, default: Facility.statuses[:idle]
    end
  end
end
