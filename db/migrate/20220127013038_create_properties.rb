class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string     :postal_code
      t.string     :prefecture,      null: false
      t.string     :city,            null: false
      t.string     :address_line
      t.string     :building,        null: false
      t.integer     :total_units
      t.date       :building_year,   null: false
      t.string     :property_type,   null: false    #物件種別
      t.string     :business_entity, null: false    #法人 or 個人
      t.timestamps
    end
  end
end
