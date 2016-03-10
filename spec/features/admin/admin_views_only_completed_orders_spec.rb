require "rails_helper"

RSpec.feature "AdminViewsCompletedOrders", type: :feature do
  scenario "they see only completed orders" do
    coffee = Category.create(name:"coffee")

    product1 = coffee.products.create(name: "Finca San Matias",
                                      price: 2500,
                                      description: "Es todo que necessita.")

    user = User.create(first_name: "john",
                       last_name: "adams",
                       fullname: "john adams",
                       email: "email@foundingfathers.biz",
                       password: "password")

    order1 = user.orders.create(street: "1600 pennslyvania",
                                city: "washington",
                                state: "District of Columbia",
                                zip: "46250",
                                fullname: "jonathon adams",
                                first_name: "jonathon",
                                last_name: "adams",
                                email: "spam@foundingfathers.biz",
                                status: "completed")

    order1.order_products.create(product_id: product1.id,
                                 quantity: 10)

    order2 = user.orders.create(street: "1600 Ohio",
                                city: "Denver",
                                state: "Colorado",
                                zip: "46250",
                                fullname: "steven jackson",
                                first_name: "steven",
                                last_name: "jackson",
                                email: "spam@foundingfathers.biz")

     order2.order_products.create(product_id: product1.id,
                                  quantity: 5)

    admin = User.create(first_name: "john",
                        last_name: "admin",
                        fullname: "john admin",
                        email: "admin@example.com",
                        password: "password",
                        role: 1)

    visit "/"
    click_on "login"
    fill_in "email", with: admin.email
    fill_in "password", with: admin.password
    click_on "login"
    visit admin_dashboard_path

    click_on "completed orders"

    expect(current_path).to eq(admin_orders_path)

    within "tr##{order1.id}-order" do
      expect(page).to have_content(order1.id)
      expect(page).to have_content(order1.fullname)
      expect(page).to have_content(order1.total)
      expect(page).to have_content(order1.product_quantity)
    end

    expect(page).to_not have_content(order2.fullname)
    expect(page).to_not have_content(order2.total)

    click_on(order1.id)

    expect(current_path).to eq(admin_order_path(order1.id))

    within "div#customer-information" do
      expect(page).to have_content(order1.first_name)
      expect(page).to have_content(order1.last_name)
      expect(page).to have_content("1600 pennslyvania")
      expect(page).to have_content(order1.city)
      expect(page).to have_content(order1.state)
      expect(page).to have_content(order1.zip)
    end

    within "div#order-information" do
      expect(page).to have_content(order1.id)
      expect(page).to have_button("update")
      select "cancelled", from: "order_status"
    end

    click_on "update"

    expect(current_path).to eq(admin_orders_path)
    expect(Order.first.status).to eq("cancelled")

  end
end
