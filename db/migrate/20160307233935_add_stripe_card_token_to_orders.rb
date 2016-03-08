class AddStripeCardTokenToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :card_token, :string
  end
end
