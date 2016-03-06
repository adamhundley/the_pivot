class AddInactiveToProducts < ActiveRecord::Migration
  def change
    add_column :products, :inactive, :boolean, default: false
  end
end
