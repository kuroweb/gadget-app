class BoardTagMap < ApplicationRecord

  ###################
  #  アソシエーション  #
  ###################
  belongs_to :board
  belongs_to :tag

  ################
  # バリデーション #
  ################
  validates :board_id, presence: true
  validates :tag_id, presence: true
  
end
