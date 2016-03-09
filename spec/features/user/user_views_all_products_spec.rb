require "rails_helper"

RSpec.feature "UserViewsAllProducts", type: :feature do
  scenario "user views all products" do
    category = Category.create(name:"coffee")
    product = category.products.create(name:"Ethiopian", price:1500, description:"Ethiopian coffee is super good")

    visit root_path

    click_on "shop all"

    within "div#products" do
      expect(page).to have_content(product.name)
    end
  end
end
