require "rails_helper"

RSpec.feature "AdminUsesSearchFeatureForOrders", type: :feature do
  before(:each) do
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
                                status: "cancelled")

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
  end

  scenario "they search by id" do
    click_on "active orders"

    fill_in "search by order id", with: 324234
    click_on "search by id"

    expect(page).to have_content("Order 324234 doesn't exist silly!")

    fill_in "id_search", with: "#{Order.last.id}"
    click_on "search by id"

    expect(current_path).to eq(admin_order_path("#{Order.last.id}"))

    expect(page).to have_content("#{Order.last.total}")
    expect(page).to have_content("#{Order.last.order_products.first.product.name}")
    expect(page).to have_content("#{Order.last.fullname}")
    expect(page).to have_content("#{Order.last.street}")
    expect(page).to have_content("#{Order.last.city}")
    expect(page).to have_content("#{Order.last.state}")
    expect(page).to have_content("#{Order.last.zip}")
  end

  scenario "they search by name" do
    click_on "active orders"

    fill_in "search by name", with: "jonathon adams"
    click_on "search by name"

    expect(current_path).to eq(admin_orders_path)
    expect(page).to have_content("#{Order.first.fullname}")

  end

  scenario "they search by date" do
    click_on "active orders"

    fill_in "date_search", with: "#{Order.first.updated_at.strftime("%B %-d, %Y")}"

    click_on "search by date"

    expect(current_path).to eq(admin_orders_path)
    expect(page).to have_content("#{Order.last.fullname}")
  end
end
