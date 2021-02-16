class BoardComment < ApplicationRecord
  include Rails.application.routes.url_helpers

  ################################################################################################
  # アソシエーション
  ################################################################################################
  has_many_attached :images
  belongs_to :board
  belongs_to :user
  has_many :notices, dependent: :destroy

  ################################################################################################
  # バリデーション
  ################################################################################################
  validates :description, presence: true, length: { maximum: 255 }

  ################################################################################################
  # 画像データのURLを取得
  ################################################################################################
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

  ################################################################################################
  # 通知作成
  ################################################################################################
  def notice_comment(visitor_id, board_id)
    board = Board.find(board_id)
    visitor = User.find(visitor_id)

    # マイクロポストの投稿者への通知
    contributor_notice = visitor.active_notices.new(
      visitor_id: visitor.id,
      visited_id: board.user.id,
      board_id: board.id,
      action: 'board_comment'
    )
    if visitor_id != board.user.id
      contributor_notice.save
    end

    # 他にコメントしていた人への通知
    users = []
    board.board_comments.each do |c|
      users.push(c.user)
    end
    users.uniq.each do |user|
      comment_notice = visitor.active_notices.new(
        visitor_id: visitor.id,
        visited_id: user.id,
        board_id: board.id,
        action: 'board_comments'
      )
      if visitor_id != user.id
        comment_notice.save
      end
    end
  end

end
