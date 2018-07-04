class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :starts
      t.text :review
      t.integer :upvotes
      t.integer :downvotes
      t.text :reply_from_hotel
      t.bigint :hotel_id, null: false
      t.bigint :user_id, null: false

      t.timestamps
    end

    add_foreign_key :ratings, :hotels, ondelete: :cascade
    add_foreign_key :ratings, :users, ondelete: :cascade
    add_index :ratings, :created_at

  end
end
