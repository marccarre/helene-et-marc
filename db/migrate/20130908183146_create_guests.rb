class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :family_name
      t.string :email
      t.string :phone
      t.string :address
      t.string :postcode
      t.string :country
      t.boolean :retour
      t.datetime :registered_on

      t.timestamps
    end
  end
end
