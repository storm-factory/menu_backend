require 'rails_helper'

RSpec.describe Menu, type: :model do
  before(:each) do
    @restaurant = Restaurant.create(name: "Carl's Diner", address: "123 Easy Street", phone: "1(815)867-5309")
  end

  it "must have a name" do
    expect { Menu.create!(restaurant: @restaurant) }.to raise_error(ActiveRecord::RecordInvalid)

    menu = Menu.create!(name: "Appetizers", restaurant: @restaurant)
    expect( menu.valid? ).to be_truthy
  end

  it "can have multiple menu items" do
    menu = Menu.create!(name: "Appetizers",restaurant: @restaurant)

    menu_items = [
                    {name: "Fries", description: "French fried potatoes.", price: "3.99", menu: menu},
                    {name: "Nachos", description: "Chips with melted cheese and salsa.", price: "7.99", menu: menu},
                    {name: "Mozzarella Sticks", description: "I think they are just fried cheese? Comes with dipping sauce.", price: "5.99", menu: menu}
                  ]

    menu_items.each do |item|
      MenuItem.create!(item)
    end
    menu.save

    expect(menu.menu_items.length).to equal 3
  end
end
