require 'rails_helper'

RSpec.feature "UserChangesQunatityOfProductInCart", type: :feature do
  scenario "they change the quanity of a product and see it updated in the cart" do
    category = Category.create(name:"coffee")
    product = category.products.create(name:"Ethiopian", price:1500, description:"Ethiopian coffee is super good")

    visit "/products/#{product.id}"
    click_on "Add to cart"

    visit cart_path

    expect(page).to have_content("1")

    within "div#quantity-dropdown" do
      select "3",from: "quantity"
    end

    click_on "Update"

    expect(current_path).to eq(cart_path)

    expect(page).to have_content("3")
    expect(page).to have_content("Order Total $45")
  end
end
