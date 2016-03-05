class AddSaleToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sale?, :boolean, default: false
    add_column :products, :sale_price, :integer
  end
end
