class Image

  has_attached_file :image,
      styles: { index: '275x175>', show: '550x350<', small: '137.5x87.5>' },
      default_url: "logo.ico"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end

