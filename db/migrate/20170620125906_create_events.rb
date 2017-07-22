class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.timestamps

      t.belongs_to :sensor
      t.belongs_to :facility

      t.integer :sensor_status, null: false, default: 0
      t.integer :facility_status, null: false, default: 0
    end
  end
end
