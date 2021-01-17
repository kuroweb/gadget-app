class UserTagMap < ApplicationRecord

  ###################
  #  アソシエーション  #
  ###################
  belongs_to :user
  belongs_to :tag

  ################
  # バリデーション #
  ################
  validates :user_id, presence: true
  validates :tag_id, presence: true
  
end
