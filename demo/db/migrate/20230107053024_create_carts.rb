class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :menu_item, null:false, foreign_key:{to_table: :menu_items}
      t.references :user, null:false, foreign_key:{to_table: :users}
      t.integer :quantity, null:false
      t.timestamps
    end
  end
end
