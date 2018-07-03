class CreateDishTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :dish_types do |t|

      t.timestamps
    end
  end
end
