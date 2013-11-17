class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.references :car, index: true

      t.string :first_name
      t.string :family_name
      t.string :email
      t.string :phone

      t.timestamps
    end

    add_index :passengers, :id
  end
end
