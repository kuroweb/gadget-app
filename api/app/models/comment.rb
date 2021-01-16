class Comment < ApplicationRecord
  include Rails.application.routes.url_helpers

  ###################
  #  アソシエーション  #
  ###################
  has_many_attached :images
  belongs_to :user
  belongs_to :post

  ################
  # バリデーション #
  ################
  validates :description, presence: true, length: { maximum: 255 }

  ################
  #   メソッド    #
  ################
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
