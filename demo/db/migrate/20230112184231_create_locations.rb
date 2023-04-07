class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.references :user, null: false, foreign_key:{to_table: :users}, index:{unique: true}
      t.float :longitude, null: false
      t.float :latitude, null: false
      t.timestamps
    end
  end
end
