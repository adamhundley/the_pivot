class ImageCreator
  def self.create_images(images, property)
    images.each do |image|
      property.images.create(image: image)
    end
  end
end
