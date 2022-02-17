class ManagementCompany < ApplicationRecord
  # validates :name, presence: true

  belongs_to :user
  has_many :property

end
