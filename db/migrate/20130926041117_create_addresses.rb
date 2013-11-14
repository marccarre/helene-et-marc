class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :booking, index: true
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.string :postcode
      t.string :country

      t.timestamps
    end

    add_index :addresses, :id
  end
end
