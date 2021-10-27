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

  ###
  # Predicts what day a user might order based off the frequency of them ordering on that day
  #
  # @return [String] The name of the day the user is most likely to order
  ###
  def predict_day_of_order
    frequency_of_order_by_day = Order.select("dayname(orders.date)").where("orders.user_id = ?",self.id).group("dayname(orders.date)").count
    return frequency_of_order_by_day.first[0]
  end

  ###
  # Predicts what day and main dish a user might order based off the frequency of them ordering that dish on that day
  #
  # @return [Array] an array with the first element being the day and the second the menu item name
  ###
  def predict_day_and_order
    day = self.predict_day_of_order
    order = predict_order_by_day_week day, :main_dish
    return [day,order]
  end
end
