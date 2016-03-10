require "rails_helper"

RSpec.feature "AdminCantAddProductWithoutCategory", type: :feature do
  scenario "they see the correct flash message when adding a product with a missing category" do
    admin = User.create(fullname: "john adams",
                        email: "admin@example.com",
                        password: 'password',
                        role: 1)

    Category.create(name: "coffee")
    visit "/"

    click_on "login"

    fill_in "email", with: admin.email
    fill_in "password", with: admin.password

    click_on "login"

    visit admin_dashboard_path

    click_on "add product"

    expect(current_path).to eq(new_admin_product_path)

    within "div#new-product" do
    fill_in "name", with: "Ethiopian"
    fill_in "price", with: 100
    fill_in "description", with: "is guud"
    click_on "create product"
    end

    expect(page).to have_content("Sorry, boss lolololololololol. Something went wrong :(... Please try again.")
  end
end
