class Tag < ApplicationRecord

  ###################
  #  アソシエーション  #
  ###################
  has_many :post_tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :tag_maps
  has_many :board_tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :boards, through: :board_tag_maps
  has_many :user_tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :users, through: :user_tag_maps

  ################
  # バリデーション #
  ################
  validates :tag_name, presence: true, length: { maximum: 20 }

  ################
  #   メソッド    #
  ################
  def self.search(tag_name)
    Tag.where(['tag_name LIKE ?', "%#{tag_name}%"])
  end

end
