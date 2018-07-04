class CreateDishTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :dish_types do |t|
      t.string :name

      t.timestamps
    end

    add_index :dish_types, :name
  end
end
