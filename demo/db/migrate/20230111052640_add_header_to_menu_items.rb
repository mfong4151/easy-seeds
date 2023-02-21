class AddHeaderToMenuItems < ActiveRecord::Migration[7.0]
  def change
    add_column :menu_items, :header, :string
  end
end
