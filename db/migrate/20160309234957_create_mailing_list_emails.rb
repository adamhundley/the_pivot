class CreateMailingListEmails < ActiveRecord::Migration
  def change
    create_table :mailing_list_emails do |t|
      t.string :email
    end
  end
end
