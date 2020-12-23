class UserTagMap < ApplicationRecord
  belongs_to :user
  belongs_to :tag

  validates :user_id, presence: true
  validates :tag_id, presence: true
end
