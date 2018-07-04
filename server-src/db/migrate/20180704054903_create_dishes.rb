class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.string :name
      t.text :description
      t.text :picture_url
      t.bigint :hotel_id, null: false
      t.bigint :dish_id, null: false
      t.timestamps
    end

    add_foreign_key :open_hours, :hotels, on_delete: :cascade
    add_foreign_key :open_hours, :dishes
  end
end
