class BoardTagMap < ApplicationRecord
  belongs_to :board
  belongs_to :tag

  validates :board_id, presence: true
  validates :tag_id, presence: true
end
