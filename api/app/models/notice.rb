class Notice < ApplicationRecord
  default_scope -> { order(created_at: :desc)}

  ###################
  #  アソシエーション  #
  ###################
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :board, optional: true
  belongs_to :board_comment, optional: true

  ################
  # バリデーション #
  ################


  ################
  #   メソッド    #
  ################
end
