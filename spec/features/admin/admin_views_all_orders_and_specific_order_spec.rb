require 'rails_helper'

RSpec.feature "AdminViewsAllOrders", type: :feature do
  scenario "they see all of the orders" do
    coffee = Category.create(name:"coffee")

    product1 = coffee.products.create(name:"Finca San Matias", price: 2500, description:"Es todo que necessita.", image: open("https://s3.amazonaws.com/littleowl-turing/products/finca_san_matias.jpg"))
    product2 = coffee.products.create(name:"Gatchatha AA Kenya", price: 2000, description:"Gatchatha have it.", image: open("https://s3.amazonaws.com/littleowl-turing/products/gatchatha_aa_kenya.jpg"))
    product3 = coffee.products.create(name:"Inter Continental Pack", price: 4000, description:"Study abroad.", image: open("https://s3.amazonaws.com/littleowl-turing/products/inter_continental_pack.jpg"))


    user = User.create(first_name: "john", last_name: "adams", email: "email@foundingfathers.biz", password: "password")

    order1 = user.orders.create(street: "1600 pennslyvania", city: "washington", state: "District of Columbia", zip: "46250", first_name: "jonathon", last_name: "adams", email: "spam@foundingfathers.biz")
      order_product1 = order1.order_products.create(product_id: product1.id, quantity: 10)
      order_product2 = order1.order_products.create(product_id: product3.id, quantity: 11)

    order2 = user.orders.create(street: "1600 pennslyvania", city: "washington", state: "District of Columbia", zip: "46250", first_name: "jonathon", last_name: "adams", email: "spam@foundingfathers.biz")
      order_product3 = order2.order_products.create(product_id: product2.id, quantity: 1)
      order_product4 = order2.order_products.create(product_id: product3.id, quantity: 2)

    admin = User.create(first_name: "john",
                        last_name: "admin",
                        email: "admin@example.com",
                          password: 'password',
                          role: 1
                          )

    visit '/'
    click_on "login"
    fill_in "email", with: admin.email
    fill_in "password", with: admin.password
    click_on "login"
    visit admin_dashboard_path

    click_on "orders"

    expect(current_path).to eq(admin_orders_path)

    within "tr##{order1.id}-order" do
      expect(page).to have_content(order1.id)
      expect(page).to have_content(order1.first_name)
      expect(page).to have_content(order1.last_name)
      expect(page).to have_content(order1.total)
      expect(page).to have_content(order1.product_quantity)
      expect(page).to_not have_content(order2.total)

      fill_in "comment", with: "this is test comment, jonathon."

      select "completed", from: "order_status"
      click_on "update"

      expect(current_path).to eq(admin_orders_path)
      expect(Order.first.status).to eq("completed")

      expect(Order.first.comment).to eq("this is test comment, jonathon.")

      click_on(order1.id)
      save_and_open_page

      expect(current_path).to eq(admin_order_path(order1.id))

        expect(page).to have_content(order1.id)
        expect(page).to have_content(order1.total)
        expect(page).to have_content(order1.product_quantity)
        expect(Order.first.status).to eq("completed")
        expect(Order.first.comment).to eq("this is test comment, jonathon.")
        expect(page).to have_button("update")


        expect(page).to have_content(order1.first_name)
        expect(page).to have_content(order1.last_name)
        expect(page).to have_content("1600 pennslyvania")
        expect(page).to have_content(order1.city)
        expect(page).to have_content(order1.state)
        expect(page).to have_content(order1.zip)

        fill_in "comment", with: "blah blah blah."

        expect(page).to have_content(order_product1.product.name)
        expect(page).to have_content(order_product1.quantity)
        expect(page).to have_content(order_product1.product.price)
        expect(page).to have_content(order_product1.total)
    end
  end
end
