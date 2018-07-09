class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.integer :avg_price_for_person
      t.integer :min_order
      t.string :contact_number
      t.decimal :latitude, precision: 15, scale: 10
      t.decimal :longitude, precision: 15, scale: 10


      t.integer :from_week_day, limit: 2
      t.integer :to_week_day, limit: 2
      t.time :from_hour_of_day
      t.time :to_hour_of_day

      t.timestamps
    end

    add_index :hotels, :name

  end
end