class AddColumnToDishTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :dish_types, :name, :string
  end
end
