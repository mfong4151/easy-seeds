class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user, null:false, foreign_key:{to_table: :users}
      t.references :restaurant, null:false, foreign_key:{to_table: :restaurants}
      t.float :transaction_sum, null:false
      t.timestamps
    end
  end
end
