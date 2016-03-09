require "rails_helper"

RSpec.feature "UserCanLoginToExistingAccount", type: :feature do
  scenario "user logs in to account" do
    category = Category.create(name:"coffee")
    product = category.products.create(name:"Ethiopian", price:1500, description:"Ethiopian coffee is super good")
    user = User.create(first_name: "John", last_name: "Adams", fullname: "John Adams", email: "email@example.com", password: "password")

    visit "/products/#{product.id}"
    click_on "Add to cart"

    visit "/"

    click_on "login"

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    click_on "login"

    expect(page).to have_content("Hey John, welcome to Little Owl.")

    expect(current_path).to eq("/")

    expect(page).to_not have_link("login")
    expect(page).to have_content("John")
    expect(page).to have_link("logout")
    expect(page).to have_link("order history")
    expect(page).to have_link("settings")

    click_on "cart"
    expect(page).to have_content("Ethiopian")

    click_on "Continue Shopping"

    expect(current_path).to eq("/products")

    click_on "logout"

    expect(page).to have_link("login")
    expect(page).to_not have_link("logout")
    expect(page).to_not have_link("order history")
    expect(page).to_not have_link("settings")
    expect(page).to_not have_content("John Adams")

  end
end
