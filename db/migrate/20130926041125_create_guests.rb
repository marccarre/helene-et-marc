class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.references :booking, index: true
      t.string :first_name
      t.string :family_name
      t.date :birth_date
      t.boolean :child_menu

      t.timestamps
    end
  end
end
