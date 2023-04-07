class EditCartItemsIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :cart_items, [:cart_id, :menu_item_id], unique: true
  end
end
