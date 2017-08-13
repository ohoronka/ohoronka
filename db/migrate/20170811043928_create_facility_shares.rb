class CreateFacilityShares < ActiveRecord::Migration[5.1]
  def change
    create_table :facility_shares do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :facility, foreign_key: true

      t.timestamps
    end
  end
end
