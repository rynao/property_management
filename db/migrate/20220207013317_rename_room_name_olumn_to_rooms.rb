class RenameRoomNameOlumnToRooms < ActiveRecord::Migration[6.0]
  def change
    rename_column :rooms, :room_name, :name
  end
end
