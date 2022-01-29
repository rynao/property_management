class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.date       :start_date, null: false
      t.date       :end_date,   null: false
      t.integer    :rent,       null: false
      t.references :property,   null: false, foreign_key: true
      t.references :room,       null: false, foreign_key: true
      t.timestamps
    end
  end
end
