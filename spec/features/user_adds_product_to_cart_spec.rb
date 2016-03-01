require "rails_helper"

RSpec.feature "UserAddsProductToCart", type: :feature do
  scenario "user adds product to cart" do
    category = Category.create(name:"coffee")
    product = category.products.create(name:"Ethiopian", price:1500, description:"Ethiopian coffee is super good", image_url:"http://www.ethiopia-xperience.com/images/Pics_uploaded_by_Jos/EthiopianCoffee2010_586.jpg")

    visit "/products/#{product.id}"

    click_on "Add to Cart"

    expect(page).to have_content("Ethiopian added to cart")
    expect(current_path).to eq("/products")


  end
end
