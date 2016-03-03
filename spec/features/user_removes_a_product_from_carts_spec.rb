require 'rails_helper'

RSpec.feature "UserRemovesAProductFromCarts", type: :feature do
  scenario "they see all that the removed item is no longer there" do
    category = Category.create(name:"coffee")
    product = category.products.create(name:"Ethiopian", price:1500, description:"Ethiopian coffee is super good", image_url:"http://www.ethiopia-xperience.com/images/Pics_uploaded_by_Jos/EthiopianCoffee2010_586.jpg")

    product2 = category.products.create(name:"Columbian", price:1800, description:"Columbian coffee is super good", image_url:"https://lh3.googleusercontent.com/qi7THVboCbSZT8QK9uj2vLOPRF4beBNy6jJw1n5zJi2pfk_qHG68RXiOnFQG9zYNHCDBJgtV_GjW09Mt7SKQuOIW0Qlqhufd5Un6rBmwpfuxxlwaeYPSCKJPiKOEBdm6pr1m290LMgmDmyxlOoVXo2uE_uPMHb7J0p2mmYYQQ2qrHmFBNTqbDNTZLSeJWYzhFxEJKiYK8i-izsKfkqVVAiEIkm3fzCz_sTeJpc2ix6TEK1z3bMmng7oHN3zalGI2tp0z7KkG8dRrY4TcdmrNvb1SihBrUXEaKURWWK9nS0D0zoAG20TqBI7PS8Efk7iannh320Ed_pO8Blq6-uhlgHFXqlhgoNcIeNixGO8yyfm2zs2N7y4yU-CVeLUZGe4x2HjYpk8bZiYEjeC7Ovxw2_IhaMROrj9vCCoz-xP5ZCm8St16WZT3PKbAYX8K85vYqYL90YgX3fl6p9Cwq6Rj6gjMCXm46Oq_WMCctu2N6ENue_5oR87cx5LhOOc8YiBj5M1y_o-B2Wnns31gLuwefYDRzW66JFfqbyuku-JhEQVfh-EiKl_6SRI1OjreiJMKKc1Y=w1088-h836-no")

    visit "/products/#{product.id}"
    click_on "Add to cart"

    visit "/products/#{product2.id}"
    click_on "Add to cart"

    visit cart_path
    within("div##{product.id}-product") do
      click_on "remove from cart"
    end

    expect(current_path).to eq(cart_path)

    expect(page).to have_content("You have removed #{product.name} from your cart.")

    expect(page).to_not have_content(product.description)
    expect(page).to_not have_content(product.image_url)
    expect(page).to_not have_content(product.price/100)

    expect(page).to have_link "#{product.name}"
    expect(page).to have_content("Order Total $18")
  end
end
