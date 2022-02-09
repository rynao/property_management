class ChangeColumnFloatToRooms < ActiveRecord::Migration[6.0]
  def change
    change_column :rooms, :room_size, :float

  end
end
