class AddFkCarts < ActiveRecord::Migration[7.0]
  def change
    add_reference :carts, :restaurant, null:false, foreign_key:{to_table: :restaurants}
  end
end
