class AddColumnsToContracts < ActiveRecord::Migration[6.0]
  def change
    add_column :contracts, :contractor, :string
  end
end
