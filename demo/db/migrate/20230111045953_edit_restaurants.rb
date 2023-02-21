class EditRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :cuisine_type, :string
  end
end
