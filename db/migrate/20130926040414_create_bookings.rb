class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.boolean :coming
      t.string :comments
      
      t.timestamps
    end

    add_index :bookings, :id
  end
end
