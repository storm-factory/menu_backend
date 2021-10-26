class MenuItem < ApplicationRecord
  has_and_belongs_to_many :menus
  has_many :sides, class_name: "MenuItem", foreign_key: :menu_item_id
  belongs_to :main_dish, class_name: "MenuItem", optional: true

  validates :name, :description, :price, presence: true
  validates :name, uniqueness: true

  enum options: [:main_dish, :side_dish]


end
