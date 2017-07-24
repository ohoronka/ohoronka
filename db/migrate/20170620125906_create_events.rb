class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.timestamps

      t.belongs_to :target, polymorphic: true
      t.belongs_to :facility

      t.integer :target_status, null: false, default: 0
      t.integer :facility_status, null: false, default: 0
    end
  end
end
