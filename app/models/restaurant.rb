class Restaurant < ApplicationRecord
  validates :name, :address, :phone, presence: true
end
