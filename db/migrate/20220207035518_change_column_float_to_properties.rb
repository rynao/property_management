class ChangeColumnFloatToProperties < ActiveRecord::Migration[6.0]
  def change
    change_column :properties, :land_area, :float
    change_column :properties, :building_area, :float
  end
end
