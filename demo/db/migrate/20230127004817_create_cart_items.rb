class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :menu_item, null: false, foreign_key:{to_table: :menu_items}
      t.references :cart, null: false, foreign_key:{to_table: :carts}
      t.integer :quantity, null: false
      t.timestamps
    end
  end
end
