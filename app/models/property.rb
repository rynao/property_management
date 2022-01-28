class Property < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :contracts, dependent: :destroy
end
