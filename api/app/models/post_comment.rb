class PostComment < ApplicationRecord
  include Rails.application.routes.url_helpers

  ###################
  #  アソシエーション  #
  ###################
  has_many_attached :images
  belongs_to :user
  belongs_to :post
  has_many :notices, dependent: :destroy

  ################
  # バリデーション #
  ################
  validates :description, presence: true, length: { maximum: 255 }

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

  def notice_comment(visitor_id, post_id)
    post = Post.find(post_id)
    visitor = User.find(visitor_id)

    # マイクロポストの投稿者への通知
    contributor_notice = visitor.active_notices.new(
      visitor_id: visitor.id,
      visited_id: post.user.id,
      post_id: post.id,
      action: 'post_comment'
    )
    if visitor_id != post.user.id
      contributor_notice.save
    end

    # 他にコメントしていた人への通知
    users = []
    post.post_comments.each do |c|
      users.push(c.user)
    end
    users.uniq.each do |user|
      comment_notice = visitor.active_notices.new(
        visitor_id: visitor.id,
        visited_id: user.id,
        post_id: post.id,
        action: 'post_comments'
      )
      if visitor_id != user.id
        comment_notice.save
      end
    end
  end
  
end
