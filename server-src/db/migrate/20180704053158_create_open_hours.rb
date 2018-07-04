class CreateOpenHours < ActiveRecord::Migration[5.2]
  def change
    create_table :open_hours do |t|
      t.integer :from_week_day, limit: 2
      t.integer :to_week_day, limit: 2
      t.time :from_hour_of_day
      t.time :to_hour_of_day
      t.bigint :hotel_id, null: false
      t.timestamps
    end

    add_foreign_key :open_hours, :hotels, on_delete: :cascade

  end
end