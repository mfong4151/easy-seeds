class EditRestaurantsDesc < ActiveRecord::Migration[7.0]
  def change
    remove_column :restaurants, :description
  end
end
