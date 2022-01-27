class Room < ApplicationRecord
  belongs_to :property
  has_many :contracts
end
