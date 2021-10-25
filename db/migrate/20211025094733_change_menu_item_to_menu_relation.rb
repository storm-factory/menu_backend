class ChangeMenuItemToMenuRelation < ActiveRecord::Migration[6.1]
  def change
    create_join_table :menus, :menu_items
    remove_column :menu_items, :menu_id
  end
end
