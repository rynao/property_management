class AddUserIdToManagementCompanies < ActiveRecord::Migration[6.0]
  def change
    add_reference :management_companies, :user, foreign_key: true
  end
end
