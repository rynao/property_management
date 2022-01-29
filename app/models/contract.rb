class Contract < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :rent, presence: true, numericality: true

  belongs_to :property
  belongs_to :room
end
