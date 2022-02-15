class CreateManagementCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :management_companies do |t|
      t.string    :name, null: false
      t.string    :department
      t.string    :sales_person
      t.string    :telephone
      t.string    :email
      t.timestamps
    end
  end
end
