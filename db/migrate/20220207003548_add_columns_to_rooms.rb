class AddColumnsToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :layout, :string
    add_column :rooms, :room_size, :integer
    add_column :rooms, :direction, :string
  end
end
