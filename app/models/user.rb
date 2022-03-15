class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :recoverable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  has_many :management_companies, dependent: :destroy
  has_many :property, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :contracts, dependent: :destroy
  has_many :payments, dependent: :destroy
end
