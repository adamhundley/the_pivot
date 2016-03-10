require 'spec_helper'

RSpec.describe OrderMailer do
  describe 'email' do
    let(:order) { mock_model Order, first_name: 'Lucas', last_name: "Jones", street: "123 St.", city: "Denver", state: "CO", zip: "80209", user_id: 3, email: 'lucas@email.com', fullname: "Lucas Jones", order_total: "40", mock_model OrderProduct, product_id: 1, order_id: order.id, quantity: 1}



    require "pry"; binding.pry}

    let(:mail) { OrderMailer.order_email(order) }

    it 'renders the subject' do
      expect(mail.subject).to eql('test confirmation email')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['littleowlturing@gmail.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(user.name)
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded)
        .to match("http://aplication_url/#{user.id}/confirmation")
    end
  end
end
