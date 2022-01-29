class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.date       :paid_date, null: false
      t.boolean    :paid,      null: false, default: false
      t.references :property,  null: false, foreign_key: true
      t.references :room,      null: false, foreign_key: true
      t.references :contract,  null: false, foreign_key: true
      t.timestamps
    end
  end
end
