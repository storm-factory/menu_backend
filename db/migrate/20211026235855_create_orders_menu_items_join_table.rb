class CreateOrdersMenuItemsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :orders, :menu_items
  end
end
