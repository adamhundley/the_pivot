class ChangeOrders < ActiveRecord::Migration
  def change
    change_column_default :orders, :status, "paid"
  end
end
