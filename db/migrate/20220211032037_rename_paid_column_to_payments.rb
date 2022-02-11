class RenamePaidColumnToPayments < ActiveRecord::Migration[6.0]
  def change
    rename_column :payments, :paid, :not_paid
  end
end
