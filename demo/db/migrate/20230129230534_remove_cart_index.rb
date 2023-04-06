class RemoveCartIndex < ActiveRecord::Migration[7.0]
  def change
    remove_index :carts, :restaurant_id
    remove_index :carts, :user_id
  end
end
