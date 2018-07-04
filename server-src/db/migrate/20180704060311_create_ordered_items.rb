class CreateOrderedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :ordered_items do |t|
      t.integer :quantity
      t.bigint :dish_id, null: false
      t.bigint :order_detail_id, null: false
      t.timestamps
    end

    add_foreign_key :ordered_items, :order_details, on_delete: :cascade
    add_foreign_key :ordered_items, :dishes, on_delete: :cascade
  end
end
