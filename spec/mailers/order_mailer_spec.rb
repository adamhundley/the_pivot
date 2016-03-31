require 'spec_helper'

RSpec.describe OrderMailer do
  describe 'email' do
    before :each do
      @user = create(:user)
      type = create(:property_type)
      image = create(:image)
      property = create(:property)
      type.properties << property
      @user.properties << property
      amenity = create(:amenity)
      property.amenities << amenity
      property.images << image

      @reservation = Reservation.create(fullname: "Lucas Jones", street: "123 St.", city: "Denver", state: "CO", zip: "80209", user_id: @user.id, email: 'lucas@email.com', order_total: "40", property_id: property.id)

    end

    let(:mail) { OrderMailer.order_email(@reservation) }

    it 'renders the subject' do
      expect(mail.subject).to eql("You're about to C.A.M.P!")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([@reservation.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['crashatmypad@gmail.com'])
    end

    it 'assigns @order.fullname' do
      expect(mail.body.encoded).to match(@reservation.fullname)
    end
  end
end
#
