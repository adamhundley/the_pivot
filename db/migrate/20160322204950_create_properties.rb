class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :title
      t.string :description
      t.integer :price
      t.string :street
      t.string :unit
      t.string :city
      t.string :state
      t.string :zip
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :sleeps
      t.references :user, index: true, foreign_key: true
    end
  end
end
