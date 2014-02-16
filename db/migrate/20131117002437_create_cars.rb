class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :from
      t.string :to
      t.datetime :departure_time
      t.integer :available_seats
      t.integer :category

      t.timestamps
    end

    add_index :cars, :id
  end
end
