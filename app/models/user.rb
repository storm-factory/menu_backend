class User < ApplicationRecord
  has_many :orders

  validates :name, presence: true

  ###
  # Predicts what a user might order based off the frequency of them ordering a menu item
  #
  # @param [String] day_of_week Monday, Tuesday, Wednesday...
  # @param [String] dish_options :main_dish or :side_dish
  # @return [String] The name of the menu item most likely to be ordered based on frequency of total orders
  ###
  def predict_order_by_day_week day_of_week, dish_options
    frequency_of_menu_items = MenuItem.by_options(dish_options).joins(:orders).where("orders.user_id = ?",self.id).where("dayname(orders.date) = ?", day_of_week).group("menu_items.name").count
    return frequency_of_menu_items.first[0]
  end
end
