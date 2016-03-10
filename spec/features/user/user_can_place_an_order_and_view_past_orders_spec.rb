require "rails_helper"

RSpec.feature "UserCanPlaceOrderAndViewPreviousOrder", type: :feature do
  scenario "user places order and views previous orders" do
    category = Category.create(name: "coffee")
    product = category.products.create(name:"Ethiopian", price:1500,
    description:"Ethiopian coffee is super good")
    user = User.create(first_name: "John", last_name: "Adams", fullname: "John Adams",
                       email: "email@example.com", password: "password")

    visit "/products/#{product.id}"
    click_on "Add to cart"

    visit "/"

    click_on "login"

    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_on "login"

    click_on "cart"

    click_on "Checkout"


    order1 = user.orders.create(street: "1600 pennslyvania",
                                city: "washington",
                                state: "District of Columbia",
                                zip: "46250",
                                fullname: "jonathon adams",
                                first_name: "jonathon",
                                last_name: "adams",
                                email: "spam@foundingfathers.biz")

    order1.order_products.create(product_id: product.id,
                                 quantity: 10)

    click_on "order history"

    expect(current_path).to eq("/users/#{user.id}/orders")

    click_on "#{order1.id}"

    expect(page).to have_content("#{product.name}")

    visit "/users/#{user.id}/orders/#{order1.id}/thanks"

    expect(page).to have_content("We've emailed a receipt to #{order1.email}")
  end
end
