require "rails_helper"

RSpec.feature "UserCanPlaceOrderAndViewPreviousOrder", type: :feature do
  scenario "user places order and views previous orders" do
    category = Category.create(name:"coffee")
    product = category.products.create(name:"Ethiopian", price:1500, description:"Ethiopian coffee is super good", image_url:"http://www.ethiopia-xperience.com/images/Pics_uploaded_by_Jos/EthiopianCoffee2010_586.jpg")
    user = User.create(first_name: "John", last_name: "Adams", email: "email@example.com", password: "password")

    visit "/products/#{product.id}"
    click_on "Add to cart"

    visit "/"

    click_on "login"

    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_on "login"

    click_on "cart"

    click_on "Checkout"

    expect(current_path).to eq("/users/#{user.id}/orders/new")

    expect(page).to have_content("Total: $15")
    expect(page).to have_content("John")
    expect(page).to have_content("Adams")

    fill_in "Street", with: "123 Butt St."
    fill_in "Apt, Floor, Unit", with: " "
    fill_in "City", with: "Denver"
    within "div#state-dropdown" do
      select "CO",from: "State"
    end
    fill_in "Zip", with: "80207"

    fill_in "card number", with: "4444444444444444"

    within "div#exp-month" do
      select "08",from: "month"
    end

    within "div#exp-year" do
      select "2018",from: "year"
    end

    fill_in "cvv", with: "444"

    click_on "Submit Order"

    expect(page).to have_content("Thanks for your order!")
    expect(page).to have_content("Your order was successfully placed.")
    expect(page).to have_content("We've emailed a reciept to #{user.email}")
    expect(page).to have_content("If you have any questions, you can always contact us")

    visit "/"

    click_on "order history"

    expect(page).to have_content("Ethiopian")
    expect(page).to have_content("Total: $15")

    click_on "details"
    expect(page).to have_content("Ethiopian")
  end
end
