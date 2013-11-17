class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.references :driver, index: true
      t.references :car_poolers, index: true

      t.string :from
      t.string :to
      t.time :leaving_time
      t.integer :available_seats
      t.integer :category

      t.timestamps
    end

    add_index :cars, :id
  end
end
