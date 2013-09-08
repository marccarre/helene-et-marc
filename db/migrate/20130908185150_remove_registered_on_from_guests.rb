class RemoveRegisteredOnFromGuests < ActiveRecord::Migration
  def change
    remove_column :guests, :registered_on, :datetime
  end
end
