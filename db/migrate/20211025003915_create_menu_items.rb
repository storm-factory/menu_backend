class CreateMenuItems < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.boolean :vegan
      t.boolean :vegetarian
      t.boolean :gluten_free
      t.integer :menu_id

      t.timestamps
    end
  end
end
