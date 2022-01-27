class Property < ApplicationRecord
  has_many :rooms
  has_many :contracts
end
