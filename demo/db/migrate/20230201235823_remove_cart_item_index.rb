class RemoveCartItemIndex < ActiveRecord::Migration[7.0]
  def change
    remove_index :cart_items, :cart_id
    remove_index :cart_items, :menu_item_id
  end
end
