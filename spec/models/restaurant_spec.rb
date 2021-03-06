require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  before(:each) do
    @valid_attributes = {name: "Carl's Diner", address: "123 Easy Street", phone: "1(815)867-5309"}
  end

  it "must have a name" do
    invalid_attributes = @valid_attributes.clone
    invalid_attributes.delete(:name)
    expect { Restaurant.create!(invalid_attributes) }.to raise_error(ActiveRecord::RecordInvalid)

    restaurant = Restaurant.create!(@valid_attributes)
    expect( restaurant.valid? ).to be_truthy
  end

  it "must have an address" do
    invalid_attributes = @valid_attributes.clone
    invalid_attributes.delete(:address)
    expect { Restaurant.create!(invalid_attributes) }.to raise_error(ActiveRecord::RecordInvalid)

    restaurant = Restaurant.create!(@valid_attributes)
    expect( restaurant.valid? ).to be_truthy
  end

  it "must have an phone" do
    invalid_attributes = @valid_attributes.clone
    invalid_attributes.delete(:phone)
    expect { Restaurant.create!(invalid_attributes) }.to raise_error(ActiveRecord::RecordInvalid)

    restaurant = Restaurant.create!(@valid_attributes)
    expect( restaurant.valid? ).to be_truthy
  end

  it "can have multiple menus" do
    restaurant = Restaurant.create(@valid_attributes)
    app_menu   = Menu.create(name: "Appetizers", restaurant: restaurant)
    lunch_menu = Menu.create(name: "Lunch", restaurant: restaurant)

    restaurant.menus << app_menu
    restaurant.menus << lunch_menu
    restaurant.save

    expect(restaurant.menus.length).to equal 2
  end
end
