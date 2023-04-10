class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.text :body, null: false
      t.references :restaurant, null: false, index:true, foreign_key:{to_table: :restaurants}
      t.references :user, null: false, index:true, foreign_key:{to_table: :users}
      t.timestamps
    end
  end
end
