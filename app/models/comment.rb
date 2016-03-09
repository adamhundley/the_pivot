class Comment < ActiveRecord::Base
  belongs_to :order

  validates :order_id, presence: true
  validates :comment, presence: true

  def date
    created_at.strftime("%B %-d, %Y")
  end
end
