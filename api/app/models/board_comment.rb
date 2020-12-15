class BoardComment < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_many_attached :images
  belongs_to :board
  belongs_to :user

  def images_url
    if images.attached?
      i = 0
      count = images.length
      imageList = []
      while i < count
        imageList.push(url_for(images[i]))
        i += 1
      end
      return imageList
    else
      return nil
    end
  end

end
