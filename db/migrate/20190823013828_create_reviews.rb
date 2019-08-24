class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :user_id
      t.integer :car_id

      t.timestamps
    end
  end
end
