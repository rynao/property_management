class Room < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  belongs_to :property
  has_many :contracts, dependent: :destroy
  has_many :payments, dependent: :destroy

end
