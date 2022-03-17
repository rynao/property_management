class Payment < ApplicationRecord
  validates :paid_date, presence: true
  validates :amounts,  numericality: {only_integer: true}

  belongs_to :user
  belongs_to :property
  belongs_to :room
  belongs_to :contract
end
