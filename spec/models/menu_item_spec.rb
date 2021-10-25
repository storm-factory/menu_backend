require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  it "must have a menu" do
    menu = Menu.create!(name: "Appetizers")
    attributes = {name: "Fries", description: "French fried potatoes.", price: 3.99}
    expect { MenuItem.create!(attributes) }.to raise_error(ActiveRecord::RecordInvalid)

    attributes[:menu] = menu
    menu_item = MenuItem.create!(attributes)
    expect( menu_item.valid? ).to be_truthy
  end

  it "must have a name" do
    menu = Menu.create!(name: "Appetizers")
    attributes = {description: "French fried potatoes.", price: 3.99, menu: menu}
    expect { MenuItem.create!(attributes) }.to raise_error(ActiveRecord::RecordInvalid)

    attributes[:name] = "Fries"
    menu_item = MenuItem.create!(attributes)
    expect( menu_item.valid? ).to be_truthy
  end

  it "must have a description" do
    menu = Menu.create!(name: "Appetizers")
    attributes = {name: "Fries", price: 3.99, menu: menu}
    expect { MenuItem.create!(attributes) }.to raise_error(ActiveRecord::RecordInvalid)

    attributes[:description] = "French fried potatoes."
    menu_item = MenuItem.create!(attributes)
    expect( menu_item.valid? ).to be_truthy
  end

  it "must have a price" do
    menu = Menu.create!(name: "Appetizers")
    attributes = {name: "Fries", description: "French fried potatoes.", menu: menu}
    expect { MenuItem.create!(attributes) }.to raise_error(ActiveRecord::RecordInvalid)

    attributes[:price] = 3.99
    menu_item = MenuItem.create!(attributes)
    expect( menu_item.valid? ).to be_truthy
  end
end
