class Room < ApplicationRecord
  belongs_to :property
  has_many :contracts, dependent: :destroy
  has_many :payments, dependent: :destroy

end
