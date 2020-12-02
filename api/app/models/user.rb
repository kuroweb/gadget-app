class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :avatar
  has_many :active_relationships, class_name: 'Relationship',
    foreign_key: "follower_id",
    dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
    foreign_key: "followed_id",
    dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  scope :includes_posts, -> { includes(:posts) }

  def avatar_url
    avatar.attached? ? url_for(avatar) : nil
  end
  
  # フォロー機能
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

end
