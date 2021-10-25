class MenuItem < ApplicationRecord
  has_and_belongs_to_many :menus
  validates :name, :description, :price, presence: true
  validates :name, uniqueness: true
end
