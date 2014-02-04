class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :email
      t.string :phone
      t.boolean :coming
      t.string :comments
      
      t.timestamps
    end

    add_index :bookings, :id
  end
end
