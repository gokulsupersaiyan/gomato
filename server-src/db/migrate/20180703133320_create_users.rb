class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :contact_number, null: false
      t.integer :wallet_balance, default: 0
      t.string :address, null: false
      t.timestamps
    end
  end
end
