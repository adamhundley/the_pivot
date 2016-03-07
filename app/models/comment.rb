class Comment < ActiveRecord::Base
  belongs_to :order

  def date
    created_at.strftime("%B %-d, %Y")
  end
end
