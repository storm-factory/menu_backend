class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.text :notes
      t.decimal :total
      t.integer :restaurant_id
      t.integer :user_id

      t.timestamps
    end
  end
end
