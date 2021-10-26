class AddSelfJoinAndOptionsToMenuItem < ActiveRecord::Migration[6.1]
  def change
    add_column :menu_items, :menu_item_id, :integer, after: :gluten_free
    add_column :menu_items, :options, :integer, after: :description
  end
end
