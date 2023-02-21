class AddRestAvgPrice < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :avg_price, :integer
  end
end
