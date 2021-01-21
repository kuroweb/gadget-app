class GadgetTagMap < ApplicationRecord

  ###################
  #  アソシエーション  #
  ###################
  belongs_to :gadget
  belongs_to :tag

  ################
  # バリデーション #
  ################
  validates :gadget_id, presence: true
  validates :tag_id, presence: true

end
