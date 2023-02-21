class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.references :restaurant, null:false, unique:true, foreign_key: {to_table: :restaurants}
      t.timestamps
    end
  end
end

