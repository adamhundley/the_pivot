class CreatePropertyAmenities < ActiveRecord::Migration
  def change
    create_table :property_amenities do |t|
      t.references :property, index: true, foreign_key: true
      t.references :amenity, index: true, foreign_key: true
    end
  end
end
