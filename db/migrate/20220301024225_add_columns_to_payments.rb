class AddColumnsToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :amounts, :integer, null: false
  end
end
