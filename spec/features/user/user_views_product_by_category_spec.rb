require "rails_helper"

RSpec.feature "UserViewsProductsByCategory", type: :feature do
  scenario "user views products by category" do
    category = Category.create(name:"coffee")

    product = category.products.create(name: "Ethiopian", price: 1500, description: "Ethiopian coffee is super good")

    visit root_path

    click_on "coffee"

    within "div#category-products" do
      expect(page).to have_content(product.name)
      expect(page).to have_link "#{product.id}-product-image"
      expect(page).to have_link "#{product.id}-product"
    end
  end
end
