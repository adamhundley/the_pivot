class MailingListEmail < ActiveRecord::Base
  validates :email, presence: true
end
