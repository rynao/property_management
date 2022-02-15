class AddRefToProperties < ActiveRecord::Migration[6.0]
  def change
    add_reference :properties, :management_company
  end
end
