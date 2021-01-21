class Gadget < ApplicationRecord
  include Rails.application.routes.url_helpers

  ###################
  #  アソシエーション  #
  ###################
  has_many_attached :images
  belongs_to :user
  has_many :gadget_tag_maps, dependent: :destroy
  has_many :tags, through: :gadget_tag_maps
  
end
