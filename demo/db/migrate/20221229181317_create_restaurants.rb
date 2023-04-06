class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :address, null: false, unique: true
      t.text :description, null: false
      t.string :state_code, null: false
      t.string :city, null: false
      t.float :rating, null: false
      t.float :longitude, null: false
      t.float :latitude, null: false
      t.timestamps
    end
  end
end
