class AddColumnsToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :land_area, :integer
    add_column :properties, :building_area, :integer
  end
end
