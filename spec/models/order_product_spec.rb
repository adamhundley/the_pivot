# require 'rails_helper'
#
# RSpec.describe Category, :type => :model do
#   def valid_attribute
#     {
#       qauntity:               "Coffee"
#     }
#   end
#
#   it "it creates a Category" do
#     result = Category.new(valid_attribute)
#     expect(result).to be_valid
#     expect(result.name).to eq("Coffee")
#   end
#
#   it "it cannot create a category without an name" do
#     result = Category.new()
#     expect(result).to be_invalid
#   end
#
#   it "it cannot create a fan with the same name" do
#     2.times { Category.create(valid_attribute) }
#
#     result = Category.where(name: "Coffee")
#     expect(result.count).to eq(1)
#   end
#
#   it "has have many products" do
#     category = Category.create(valid_attribute)
#     product  = Product.create(name: "ethiopian", price: 100, description: "is guud", image_url:"some picture", category_id: category.id)
#     category.products << product
#
#     expect(category.products.count).to eq(1)
#     expect(category.products).to include(product)
#   end
# end
