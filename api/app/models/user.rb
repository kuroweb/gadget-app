class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :avatar
  has_many :active_relationships, class_name: 'Relationship',
    foreign_key: "follower_id",
    dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed


  # ユーザー登録時のバリデーションを今後実装



  def avatar_url
    avatar.attached? ? url_for(avatar) : nil
  end
  
end
