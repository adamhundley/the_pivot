class ChangeLabelForSale < ActiveRecord::Migration
  def change
    rename_column :products, :sale?, :sale
  end
end
