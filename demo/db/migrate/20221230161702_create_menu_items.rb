class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.string :item_name, null: false
      t.float :price, null: false
      t.references :menu, null: false, index:true, foreign_key:{to_table: :menus}
      t.timestamps
    end
  end
end
