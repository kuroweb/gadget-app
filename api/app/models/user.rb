class User < ApplicationRecord

  include Rails.application.routes.url_helpers

  # ユーザー登録時のバリデーションを今後実装

  # active_storageとの関連付け
  has_one_attached :avatar

  def avatar_url
    avatar.attached? ? url_for(avatar) : nil
  end
  
end
