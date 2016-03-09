require "rails_helper"

RSpec.feature "UserAddsProductToCart", type: :feature do
  scenario "user adds product to cart" do
    category = Category.create(name:"coffee")
    product = category.products.create(name:"Ethiopian", price:1500, description:"Ethiopian coffee is super good" )

    visit "/products/#{product.id}"

    click_on "Add to cart"

    expect(page).to have_content("Ethiopian added to cart")
    expect(current_path).to eq("/products")

    product2 = category.products.create(name:"Columbian", price:1800, description:"Columbian coffee is super good")

    visit "/products/#{product2.id}"

    click_on "Add to cart"

    expect(page).to have_content("Columbian added to cart")
    expect(current_path).to eq("/products")

    click_on "cart"

    expect(current_path).to eq("/cart")

    expect(page).to have_content(product.name)
    expect(page).to have_content(product.price/100)
    expect(page).to have_content("Order Total $33")
  end
end
