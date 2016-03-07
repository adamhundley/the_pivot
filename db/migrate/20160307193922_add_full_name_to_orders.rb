class AddFullNameToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :fullname, :string
  end
end
