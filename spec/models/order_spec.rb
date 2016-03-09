require 'rails_helper'

RSpec.describe Order, :type => :model do

  it { should validate_presence_of :user_id}
  it { should validate_presence_of :fullname}
  it { should validate_presence_of :email}
  it { should validate_presence_of :street}
  it { should validate_presence_of :city}
  it { should validate_presence_of :zip}

  it { should belong_to :user }
  it { should have_many :order_products }
  it { should have_many :products }
  it { should have_many :comments }
  
end
