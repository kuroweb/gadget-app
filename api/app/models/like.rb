class Like < ApplicationRecord

  ###################
  #  アソシエーション  #
  ###################
  belongs_to :post
  belongs_to :user

  ################
  # バリデーション #
  ################
  validates_uniqueness_of :post_id, scope: :user_id

end
