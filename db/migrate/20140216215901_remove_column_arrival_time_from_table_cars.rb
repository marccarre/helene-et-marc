class RemoveColumnArrivalTimeFromTableCars < ActiveRecord::Migration
  def self.up
    if column_exists? :cars, :arrival_time
      remove_column :cars, :arrival_time
    end
  end

  def self.down
    unless column_exists? :cars, :arrival_time
      add_column :cars, :arrival_time, :datetime
    end
  end
end
