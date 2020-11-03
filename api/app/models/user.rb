class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :avatar
  has_many :active_relationships, class_name: 'Relationship',
    foreign_key: "follower_id",
    dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  def avatar_url
    avatar.attached? ? url_for(avatar) : nil
  end
  
  # フォロー関連
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end



end
