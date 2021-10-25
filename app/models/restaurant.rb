class Restaurant < ApplicationRecord
  has_many :menus
  validates :name, :address, :phone, presence: true
end
