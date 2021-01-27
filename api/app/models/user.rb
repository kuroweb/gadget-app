class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  ################################################################################################
  # アソシエーション
  ################################################################################################
  has_one_attached :avatar
  has_many :active_relationships, class_name: 'Relationship', foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :post_comments, dependent: :destroy
  has_many :boards, dependent: :destroy
  has_many :board_comments, dependent: :destroy
  has_many :user_tag_maps, dependent: :destroy
  has_many :tags, through: :user_tag_maps
  has_many :active_notices, class_name: 'Notice', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notices, class_name: 'Notice', foreign_key: 'visited_id', dependent: :destroy
  has_many :gadgets, dependent: :destroy

  ################################################################################################
  # バリデーション
  ################################################################################################
  validates :uid, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :profile, length: { maximum: 255 }

  ################################################################################################
  # メソッド
  ################################################################################################
  def avatar_url
    avatar.attached? ? url_for(avatar) : nil
  end
  
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def followers?(other_user)
    followers.include?(other_user)
  end

  def self.search(user_name)
    User.where(['name LIKE ?', "%#{user_name}%"])
  end

  def notice_follow(visitor_id, visited_id)
    visited = User.find(visited_id)
    visitor = User.find(visitor_id)
    follow_notice = visitor.active_notices.new(
      visitor_id: visitor.id,
      visited_id: visited.id,
      action: 'follow'
    )
    follow_notice.save
  end

end
