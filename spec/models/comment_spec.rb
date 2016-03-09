require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of :comment }
  it { should validate_presence_of :order_id }

  it { should belong_to :order }

  # user = User.create(fullname: "david",
  #                       email: "whit@whit.com",
  #                       password: "password"
  #                   )
  # order = Order.create(user_id: user.id,
  #   fullname:                   "david",
  #      email:     "example@example.com",
  #     street:            "150 E. Blake",
  #       city:                  "Denver",
  #        zip:                   "46250",
  #                     )
  # comment = Comment.create(comment: "wowza", order_id: order.id)
  #
  # expect(comment.date).to eq(Time.now.strftime("%B %-d, %Y"))
end
