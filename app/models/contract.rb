class Contract < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :rent, numericality: {only_integer: true, greater_than_or_equal_to: 1, message: 'は1以上の半角整数で入力してください'}
  validates :management_cost, numericality: {only_integer: true}

  belongs_to :user
  belongs_to :property
  belongs_to :room
  has_many :payments, dependent: :nullify
end
