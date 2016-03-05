require 'rails_helper'

RSpec.feature "AdminCanAddItems", type: :feature do
  scenario "they see all added items" do
    admin = User.create(first_name: "john",
                        last_name: "adams",
                        email: "admin@example.com",
                          password: 'password',
                          role: 1
                          )
    category = Category.create(name: "coffee")
    visit '/'

    click_on "login"

    fill_in "email", with: admin.email
    fill_in "password", with: admin.password

    click_on "login"

    visit admin_dashboard_path

    click_on "add product"

    expect(current_path).to eq(new_admin_product_path)

    fill_in "name", with: "Ethiopian"
    fill_in "price", with: 100
    fill_in "description", with: "is guud"
    within "div#category-dropdown" do
      select "coffee", from: "product-category"
    end
    
  end
end
