class Board < ApplicationRecord
  include Rails.application.routes.url_helpers

  ###################
  #  アソシエーション  #
  ###################
  has_many_attached :images
  belongs_to :user
  has_many :board_tag_maps, dependent: :destroy
  has_many :tags, through: :board_tag_maps
  has_many :board_comments, dependent: :destroy
  has_many :notices, dependent: :destroy

  ################
  # バリデーション #
  ################
  validates :description, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 100 }
  validates :board_type, presence: true

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

  def save_tag(sent_tags)
    current_tags = []
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end
    new_tags.each do |new|
      new_board_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_board_tag
    end
  end

end
