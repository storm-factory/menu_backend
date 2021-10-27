require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @restaurant = Restaurant.create(name: "Carl's Diner", address: "123 Easy Street", phone: "1(815)867-5309")
    menu_items = [
                    {name: "Fries", description: "French fried potatoes.", price: 3.99},
                    {name: "Nachos", description: "Chips with melted cheese and salsa.", price: 7.99},
                    {name: "Mozzarella Sticks", description: "I think they are just fried cheese? Comes with dipping sauce.", price: 5.99},
                    {name: "Fish", description: "swimming sea creatures.", price: 9.99}
                  ]
    menu_items.each do |menu_item|
      MenuItem.create!(menu_item)
    end
  end

  it "must have a name" do
    expect { User.create! }.to raise_error(ActiveRecord::RecordInvalid)

    user = User.create!(name: "Fred")
    expect( user.valid? ).to be_truthy
  end

  it "can have many orders" do
    user = User.create!(name: "Fred")

    order = Order.create(user: user, restaurant: @restaurant)
    order.menu_items << MenuItem.find_by(name: "Fries")
    order.menu_items << MenuItem.find_by(name: "Nachos")
    order.save

    another_order = Order.create(user: user, restaurant: @restaurant)
    another_order.menu_items << MenuItem.find_by(name: "Fish")
    another_order.menu_items << MenuItem.find_by(name: "Mozzarella Sticks")
    another_order.save

    expect(user.orders.length).to equal 2
  end

  it "can predict what a user will order for a given day" do
    fridays = [
      "9/3/2021",
      "9/10/2021",
      "9/17/2021",
      "9/24/2021",
      "10/8/2021",
      "10/15/2021",
      "10/22/2021"
    ]
  end
end
