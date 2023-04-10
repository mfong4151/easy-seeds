class CreateCarts2 < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key:{to_table: :users}
      t.references :restaurant, null: false, foreign_key:{to_table: :restaurants}
      t.timestamps
    end
  end
end
