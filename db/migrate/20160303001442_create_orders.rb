class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :street
      t.string :unit
      t.string :city
      t.string :state
      t.string :zip
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
