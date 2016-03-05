require 'rails_helper'

RSpec.describe OrderProduct, :type => :model do
  def valid_attributes
    {
      quantity:               10,
      order_id:                 1,
      product_id:               1
    }
  end

  it "it creates an order product" do
    result = OrderProduct.new(valid_attributes)
    expect(result).to be_valid
    expect(result.quantity).to eq(10)
    expect(result.order_id).to eq(1)
    expect(result.product_id).to eq(1)
  end

  it "it cannot create an order product without a quantity" do
    result = OrderProduct.new(order_id: 1, product_id: 1)
    expect(result).to be_invalid
  end

  it "it cannot create an order product without a product_id" do
    result = OrderProduct.new(quantity: 1, order_id: 1)
    expect(result).to be_invalid
  end

  it "it cannot create an order product without an order_id" do
    result = OrderProduct.new(quantity: 1, product_id: 1)
    expect(result).to be_invalid
  end

  it "it belongs to a product" do
    category = Category.create(name: "Coffee")
    product  = Product.create(name: "ethiopian", price: 100, description: "is guud", image: open("https://s3.amazonaws.com/littleowl-turing/products/Bonavita+1900TS+Brewer.png"), category_id: category.id)
    order = Order.create(street: "street", unit: "unit", city: "city", state: "State", zip: "zip", first_name: "david", last_name: "whitaker", email: "email@email.com")

    attributes = valid_attributes.merge(product_id: product.id, order_id: order.id)
    result     = OrderProduct.create(attributes)

    expect(result.product).to eq(product)
  end

  it "it belongs to an order" do
    category = Category.create(name: "Coffee")
    product  = Product.create(name: "ethiopian", price: 100, description: "is guud", image: "https://s3.amazonaws.com/littleowl-turing/products/Bonavita+1900TS+Brewer.png", category_id: category.id)
    user = User.create(first_name: "david", last_name: "whitaker", email: "email@email.com", password: "password")
    order = Order.create(street: "street", unit: "unit", city: "city", state: "State", zip: "zip", first_name: "david", last_name: "whitaker", email: "email@email.com", user_id: user.id)

    attributes = valid_attributes.merge(product_id: product.id, order_id: order.id)
    result = OrderProduct.create(attributes)

    expect(result.order).to eq(order)
  end
end
