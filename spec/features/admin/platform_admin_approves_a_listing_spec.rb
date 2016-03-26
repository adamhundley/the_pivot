require "rails_helper"

RSpec.feature "platform admin approves a property listing" do
  scenario "approves property listing" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)


  end
end
# when I visit '/admin/dashboard'
# and I click on pending properties,
# Then I am redirected to '/admin/pending-properties'
# and I see a pending property,
# Then I click on that property,
# and I am redirected to 'admin/pending-properties/:property_id'
# I expect to see all information about property and pictures,
# and I click on "approve",
# then I am redirected to '/admin/pending-properties'
