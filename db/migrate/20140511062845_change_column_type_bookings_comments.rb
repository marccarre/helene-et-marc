class ChangeColumnTypeBookingsComments < ActiveRecord::Migration
  def up
    change_column :bookings, :comments, :text
  end
  def down
    # This might cause trouble for comments longer than 255 characters.
    change_column :bookings, :comments, :string
  end
end
