class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.text :delivery_address
      t.bigint :user_id, null: false
      t.bigint :hotel_id, null: false
      t.text :ordered_items, null: false
      t.timestamps
    end

    add_foreign_key :orders, :hotels, on_delete: :cascade
    add_foreign_key :orders, :users, on_delete: :cascade
  end
end
