class AddPropertyTypeToProperty < ActiveRecord::Migration
  def change
    add_reference :properties, :property_type, index: true, foreign_key: true
  end
end
