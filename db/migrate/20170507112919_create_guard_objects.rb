class CreateGuardObjects < ActiveRecord::Migration[5.1]
  def change
    create_table :guard_objects do |t|
      t.timestamps
      t.string :name
    end
  end
end
