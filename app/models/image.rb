class Image < ActiveRecord::Base
belongs_to :property

  has_attached_file :image,
      styles: { index: '275x175>', show: '550x350<', small: '137.5x87.5>' },
      default_url: "logo.ico"

  validates_attachment_content_type :image, :content_type => ["image/jpeg", "image/gif", "image/png"]
  validates_attachment_size :image, {:less_than => 2.megabytes, message: "Your image must be less than 1 mb"}

end
