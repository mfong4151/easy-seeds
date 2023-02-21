class EditTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :review_left, :boolean
  end
end
