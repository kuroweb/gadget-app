class Post < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_many_attached :images
  belongs_to :user

  def images_url
    images.attached? ? url_for(images) : nil
  end

end
