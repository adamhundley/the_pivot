class AddPropertyIdToImages < ActiveRecord::Migration
  def change
    add_reference :images, :property, index: true, foreign_key: true
  end
end
