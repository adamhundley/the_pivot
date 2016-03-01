require "rails_helper"

RSpec.feature "UserViewsAllProducts", type: :feature do
  scenario "user views all products" do
    category = Category.create(name:"coffee")
    product = category.products.create(name:"Ethiopian", price:1500, description:"Ethiopian coffee is super good", image_url:"http://www.ethiopia-xperience.com/images/Pics_uploaded_by_Jos/EthiopianCoffee2010_586.jpg")

    visit root_path

    click_on "Shop"

    within "div#products" do
      expect(page).to have_content(product.name)
      expect(page).to have_link "#{product.id}-product-image"
      expect(page).to have_link "#{product.id}-product"
    end
  end
end
