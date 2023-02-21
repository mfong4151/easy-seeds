class AddDesctoMenuItems < ActiveRecord::Migration[7.0]
  def change
    add_column :menu_items, :description, :string
  end
end
