require "rails_helper"

RSpec.feature "NonUserCanPlaceOrder", type: :feature do
  scenario "non-user places order and views previous orders" do
    category = Category.create(name: "coffee")
    product = category.products.create(name:"Ethiopian", price:1500,
    description:"Ethiopian coffee is super good" )

    visit "/products/#{product.id}"
    click_on "Add to cart"

    click_on "cart"

    click_on "Checkout"

    expect(current_path).to eq("/orders/login")

    fill_in "fullname", with: "John Adams"
    fill_in "email", with: "test@test.com"
    fill_in "password", with: "password"


    click_on "continue"
    expect(page).to have_content("$15")

    # click_on "submit order"
    #
    # fill_in "email", with: "test@test.com"
    # fill_in "Street", with: "123 Butt St."
    # fill_in "Apt, Floor, Unit", with: " "
    # fill_in "City", with: "Denver"
    # within "div#state-dropdown" do
    #   select "Colorado", from: "order-state"
    # end
    # fill_in "Zip", with: "80207"
    # #
    # click_on "Submit Order"
    #
    # expect(page).to have_content("Thanks for your order! :)")
    # expect(page).to have_content("Your order was successfully placed.")
    # expect(page).to have_content("We've emailed a receipt to test@test.com")
    # expect(page).to have_content("If you have any questions,
    #                               you can always contact us")
    #
    # visit "/"
    #
    # click_on "order history"
    #
    # expect(page).to have_content("Ethiopian")
    # expect(page).to have_content("Order total: $15")
    #
    # click_on "details"
    # expect(page).to have_content("Ethiopian")
  end
end
