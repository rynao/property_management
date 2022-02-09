class Contract < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :rent, presence: true, numericality: true

  belongs_to :user
  belongs_to :property
  belongs_to :room
  has_many :payments, dependent: :nullify
end
