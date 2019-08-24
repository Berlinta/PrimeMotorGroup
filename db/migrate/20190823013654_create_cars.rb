class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :name
      t.text :description
      t.string :drive
      t.string :make
      t.integer :line_id
      t.integer :user_id

      t.timestamps
    end
  end
end