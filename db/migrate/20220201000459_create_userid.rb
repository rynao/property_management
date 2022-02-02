class CreateUserid < ActiveRecord::Migration[6.0]
  def change
    add_reference :properties, :user, foreign_key: true
    add_reference :rooms, :user, foreign_key: true
    add_reference :contracts, :user, foreign_key: true
    add_reference :payments, :user, foreign_key: true
  end
end
