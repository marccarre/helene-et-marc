class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :comments
      
      t.timestamps
    end
  end
end
