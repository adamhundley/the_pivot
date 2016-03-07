class UpdateStatusToOrders < ActiveRecord::Migration
  def change
    change_column_default :orders, :status, default: "paid"
  end
end
