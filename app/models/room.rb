class Room < ApplicationRecord
  validates :name, presence: true
  validates :room_size, numericality: {greater_than_or_equal_to: 1.00, message: 'は1.00以上の半角数値で入力してください'}, allow_blank: true

  belongs_to :user
  belongs_to :property
  has_many :contracts, dependent: :destroy
  has_many :payments, dependent: :destroy

end
