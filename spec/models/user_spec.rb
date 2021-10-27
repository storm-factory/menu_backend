require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @restaurant = Restaurant.create(name: "Carl's Diner", address: "123 Easy Street", phone: "1(815)867-5309")
    menu_items = [
                    {name: "Fries", description: "French fried potatoes.", options: :side_dish, price: 3.99},
                    {name: "Nachos", description: "Chips with melted cheese and salsa.", options: :side_dish, price: 7.99},
                    {name: "Mozzarella Sticks", description: "I think they are just fried cheese? Comes with dipping sauce.", options: :side_dish, price: 5.99},
                    {name: "Fish", description: "swimming sea creatures.", options: :main_dish, price: 9.99},
                    {name: "Hamburger", description: "Chunk of ground meat in bread.", options: "main_dish", price: 15.99},
                    {name: "Grilled Cheese", description: "Cheese melted between two slices of carbohydrates.", options: "main_dish", price: 10.99}
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
    fred = User.create!(name: "Fred")

    fridays = [
      "2021-9-3",
      "2021-9-10",
      "2021-9-17",
      "2021-9-24",
      "2021-10-8",
      "2021-10-15",
      "2021-10-22"
    ]

    order = Order.create(user: fred, restaurant: @restaurant, date: Date.parse(fridays.delete_at(1)))
    order.menu_items << MenuItem.find_by(name: "Fries")
    order.menu_items << MenuItem.find_by(name: "Hamburger")
    order.save

    order = Order.create(user: fred, restaurant: @restaurant, date: Date.parse(fridays.delete_at(4)))
    order.menu_items << MenuItem.find_by(name: "Grilled Cheese")
    order.menu_items << MenuItem.find_by(name: "Mozzarella Sticks")
    order.save

    fridays.each do |friday|
      order = Order.create(user: fred, restaurant: @restaurant, date: Date.parse(friday))
      order.menu_items << MenuItem.find_by(name: "Fish")
      order.menu_items << MenuItem.find_by(name: "Fries")
      order.save
    end

    expect(fred.orders.length).to equal 7

    expect(fred.predict_order_by_day_week(:friday, :main_dish)).to eq "Fish"
    expect(fred.predict_order_by_day_week(:friday, :side_dish)).to eq "Fries"

  end

  it "can predict the day a user will order" do
    fred = User.create!(name: "Fred")
    days = [
      "2021-9-3",
      "2021-9-5",
      "2021-9-7",
      "2021-9-10",
      "2021-9-17",
      "2021-9-20",
      "2021-9-22",
      "2021-9-24",
      "2021-9-17",
      "2021-10-8",
      "2021-10-12",
      "2021-10-15",
      "2021-10-16",
      "2021-10-20",
      "2021-10-22"
    ]

    days.each do |day|
      order = Order.create(user: fred, restaurant: @restaurant, date: Date.parse(day))
      order.menu_items << MenuItem.all.shuffle.first
    end
    expect(fred.orders.length).to eq 15
    expect(fred.predict_day_of_order).to eq "Friday"
  end

  it "can predict the day and menu item a user will order" do
    fred = User.create!(name: "Fred")
    days = [
      "2021-9-3",
      "2021-9-5",
      "2021-9-7",
      "2021-9-10",
      "2021-9-17",
      "2021-9-20",
      "2021-9-22",
      "2021-9-24",
      "2021-9-17",
      "2021-10-8",
      "2021-10-12",
      "2021-10-15",
      "2021-10-16",
      "2021-10-20",
      "2021-10-22"
    ]

    days.each do |day|
      order = Order.create(user: fred, restaurant: @restaurant, date: Date.parse(day))
      if(order.date.friday?)
        order.menu_items << MenuItem.find_by(name: "Fish")
      else
        order.menu_items << MenuItem.all.shuffle.first
      end
    end

    expect(fred.orders.length).to eq 15
    expect(fred.predict_day_and_order).to eq ["Friday","Fish"]
  end
end
