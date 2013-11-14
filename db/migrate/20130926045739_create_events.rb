class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :locale_entry
      t.date :date
      t.time :time

      t.timestamps
    end

    add_index :events, :id

    create_table :bookings_events do |t|
      t.references :booking, index: true
      t.references :event, index: true
    end
  end
end
