class Contract < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :rent, numericality: {only_integer: true, greater_than_or_equal_to: 1, message: 'は1以上の半角整数で入力してください'}
  validates :management_cost, numericality: {only_integer: true}

  belongs_to :user
  belongs_to :property
  belongs_to :room
  has_many :payments, dependent: :nullify

  target_month = Date.today.all_month
  @occupant_rooms = Room.joins(:contracts).where(user_id: current_user.id)
                        .where("end_date >= ?", Date.today)

  gon.occupancy_rate = ((@occupant_rooms.count.to_f / Room.all.count.to_f)*100).round(2)
end
