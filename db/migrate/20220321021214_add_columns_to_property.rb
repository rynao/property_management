class AddColumnsToProperty < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :purchase_date, :date, null: false
    add_column :properties, :sold, :boolean
  end
end
