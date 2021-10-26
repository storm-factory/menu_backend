require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  it "must have a name" do
    attributes = {description: "French fried potatoes.", price: 3.99}
    expect { MenuItem.create!(attributes) }.to raise_error(ActiveRecord::RecordInvalid)

    attributes[:name] = "Fries"
    menu_item = MenuItem.create!(attributes)
    expect( menu_item.valid? ).to be_truthy
  end

  it "must have a unique name" do
    attributes = {name: "Fries", description: "French fried potatoes.", price: 3.99}
    menu_item = MenuItem.create!(attributes)
    expect( menu_item.valid? ).to be_truthy

    expect { MenuItem.create!(attributes) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "must have a description" do
    attributes = {name: "Fries", price: 3.99}
    expect { MenuItem.create!(attributes) }.to raise_error(ActiveRecord::RecordInvalid)

    attributes[:description] = "French fried potatoes."
    menu_item = MenuItem.create!(attributes)
    expect( menu_item.valid? ).to be_truthy
  end

  it "must have a price" do
    attributes = {name: "Fries", description: "French fried potatoes."}
    expect { MenuItem.create!(attributes) }.to raise_error(ActiveRecord::RecordInvalid)

    attributes[:price] = 3.99
    menu_item = MenuItem.create!(attributes)
    expect( menu_item.valid? ).to be_truthy
  end

  it "can be on multiple menus" do
    restaurant = Restaurant.create(name: "Carl's Diner", address: "123 Easy Street", phone: "1(815)867-5309")
    app_menu   = Menu.create(name: "Appetizers", restaurant: restaurant)
    lunch_menu = Menu.create(name: "Lunch", restaurant: restaurant)
    menu_item  = MenuItem.create(name: "Nachos", description: "Chips with melted cheese and salsa.", price: 7.99)

    app_menu.menu_items << menu_item
    lunch_menu.menu_items << menu_item
    app_menu.save
    lunch_menu.save

    expect(app_menu.menu_items.include?(menu_item) && lunch_menu.menu_items.include?(menu_item)).to be_truthy
  end

  it "can be a main dish with sides" do
    restaurant = Restaurant.create(name: "Carl's Diner", address: "123 Easy Street", phone: "1(815)867-5309")
    lunch_menu = Menu.create(name: "Lunch", restaurant: restaurant)

    main_dish = lunch_menu.menu_items.create(name: "Salad", description: "Food for rabbits.", options: "main_dish", price: 7.99)
    side_dish = main_dish.sides.create(name: "Ranch Dressing", description: "Radiant nectar", options: "side_dish", price: 0.99)

    expect(main_dish.sides.length).to equal 1
    expect(main_dish.sides.first == side_dish).to be_truthy

    expect(main_dish.options).to eq "main_dish"
    expect(side_dish.options).to eq "side_dish"
  end

  it "can be a main dish with any side" do
    restaurant = Restaurant.create(name: "Carl's Diner", address: "123 Easy Street", phone: "1(815)867-5309")
    lunch_menu = Menu.create(name: "Lunch", restaurant: restaurant)

    main_dish = lunch_menu.menu_items.create(name: "Hamburger", description: "Chunk of ground meat in bread.", options: "main_dish", price: 15.99)
    side_dish = main_dish.sides.create(name: "Ranch Dressing", description: "Radiant nectar", options: "side_dish", price: 0.99)

    expect(main_dish.sides.length).to equal 1
    expect(main_dish.sides.first == side_dish).to be_truthy

    expect(main_dish.options).to eq "main_dish"
    expect(side_dish.options).to eq "side_dish"
  end

  it "can be a main dish with sides with sides" do
    restaurant = Restaurant.create(name: "Carl's Diner", address: "123 Easy Street", phone: "1(815)867-5309")
    lunch_menu = Menu.create(name: "Lunch", restaurant: restaurant)


    main_dish = lunch_menu.menu_items.create(name: "Hamburger", description: "Chunk of ground meat in bread.", options: "main_dish", price: 15.99)
    side_dish = main_dish.sides.create(name: "Salad", description: "Food for rabbits.", options: "side_dish", price: 7.99)
    side_dish_side = side_dish.sides.create(name: "Ranch Dressing", description: "Radiant nectar", options: "side_dish", price: 0.99)

    expect(main_dish.sides.length).to equal 1
    expect(main_dish.sides.first == side_dish).to be_truthy
    expect(side_dish.sides.first == side_dish_side).to be_truthy

    expect(main_dish.options).to eq "main_dish"
    expect(side_dish.options).to eq "side_dish"
    expect(side_dish_side.options).to eq "side_dish"
  end
end
