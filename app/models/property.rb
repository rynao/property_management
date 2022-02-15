class Property < ApplicationRecord
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :building, presence: true
  validates :business_entity, presence: true
  validates :total_units, numericality: true
  validates :management_company, presence: true, if: :management_company_id?

  belongs_to :user
  belongs_to :management_company, optional: true
  has_many :rooms, dependent: :destroy
  has_many :contracts, dependent: :destroy
  has_many :payments, dependent: :destroy

end
