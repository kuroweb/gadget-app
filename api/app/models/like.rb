class Like < ApplicationRecord

  ################################################################################################
  # アソシエーション
  ################################################################################################
  belongs_to :post
  belongs_to :user

  ################################################################################################
  # バリデーション
  ################################################################################################
  validates_uniqueness_of :post_id, scope: :user_id

  ################################################################################################
  # 通知作成
  ################################################################################################
  def notice_post_like(visitor_id, post_id)
    post = Post.find(post_id)
    visitor = User.find(visitor_id)
    notice = visitor.active_notices.new(
      visitor_id: visitor.id,
      visited_id: post.user.id,
      post_id: post.id,
      action: 'like'
    )
    if visitor.id != post.user.id
      notice.save
    end
  end

end
