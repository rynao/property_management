class Payment < ApplicationRecord
  validates :paid_date, presence: true
  # validates :paid, inclusion: [true, false]

  belongs_to :user
  belongs_to :property
  belongs_to :room
  belongs_to :contract
end
