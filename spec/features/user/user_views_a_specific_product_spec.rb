# MODIFY FOR camp



# require "rails_helper"
#
# RSpec.feature "UserViewsASpecificProduct", type: :feature do
#   scenario "user views a specific product" do
#     category = Category.create(name:"coffee")
#     product = category.products.create(name:"Ethiopian", price:1500, description:"Ethiopian coffee is super good")
#
#     visit "/coffee"
#
#     within "div##{product.name}-link" do
#       click_on "#{product.id}-product"
#     end
#
#     expect(current_path).to eq("/products/#{product.id}")
#
#     within "div#product" do
#       expect(page).to have_content(product.name)
#       expect(page).to have_content(product.description)
#     end
#   end
# end
