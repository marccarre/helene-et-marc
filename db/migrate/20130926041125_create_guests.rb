class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.references :booking, index: true
      t.string :first_name
      t.string :family_name
      t.integer :category
      t.integer :menu

      t.timestamps
    end

    add_index :guests, :id
  end
end
