class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.integer :avg_price_for_person
      t.integer :min_order
      t.boolean :is_closed_for_now
      t.string :contact_number
      t.boolean :is_verified
      t.decimal :latitude, precision: 15, scale: 10
      t.decimal :longitude, precision: 15, scale: 10
      t.timestamps
    end

    add_index :hotels, :name
    add_index :hotels, :is_closed_for_now
    add_index :hotels, :is_verified

  end
end
