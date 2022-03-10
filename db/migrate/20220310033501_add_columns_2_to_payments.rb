class AddColumns2ToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :checked, :boolean
  end
end
