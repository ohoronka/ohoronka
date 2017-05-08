class CreateGuardedObjects < ActiveRecord::Migration[5.1]
  def change
    create_table :guarded_objects do |t|
      t.timestamps
      t.belongs_to :account
      t.string :name
      t.integer :status, null: false, default: 0
    end
  end
end
