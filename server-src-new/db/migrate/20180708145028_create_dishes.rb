class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.string :dish_name
      t.text :description
      t.text :picture_url
      t.bigint :hotel_id, null: false
      t.text :dish_type, null: false
      t.integer :price, null: false
      t.timestamps
    end


    add_foreign_key :dishes, :hotels, on_delete: :cascade
    add_index :dishes, :dish_name

  end
end
