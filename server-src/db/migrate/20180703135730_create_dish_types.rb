class CreateDishTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :dish_types do |t|
      t.string :dish_type

      t.timestamps
    end

    add_index :dish_types, :dish_type
  end
end
