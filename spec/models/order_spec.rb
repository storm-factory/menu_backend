require 'rails_helper'

RSpec.describe Order, type: :model do

  before(:each) do
    @user =  User.create(name: "Fred")
    @restaurant = Restaurant.create(name: "Carl's Diner", address: "123 Easy Street", phone: "1(815)867-5309")
  end

  it "can have many menu items" do
    order = Order.create(user: @user, restaurant: @restaurant)

    menu_items = [
                    {name: "Fries", description: "French fried potatoes.", price: 3.99},
                    {name: "Nachos", description: "Chips with melted cheese and salsa.", price: 7.99},
                    {name: "Mozzarella Sticks", description: "I think they are just fried cheese? Comes with dipping sauce.", price: 5.99}
                  ]

    menu_items.each do |item|
      menu_item = MenuItem.create!(item)
      order.menu_items << menu_item
    end
    order.save

    expect(order.menu_items.length).to equal 3
  end
end
