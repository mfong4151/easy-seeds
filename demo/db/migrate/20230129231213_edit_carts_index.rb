class EditCartsIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :carts, [:user_id, :restaurant_id], unique: true
  end
end
