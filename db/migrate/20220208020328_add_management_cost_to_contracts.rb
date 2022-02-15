class AddManagementCostToContracts < ActiveRecord::Migration[6.0]
  def change
    add_column :contracts, :management_cost, :integer, null: false
  end
end
