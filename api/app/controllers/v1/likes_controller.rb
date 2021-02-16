class V1::LikesController < ApplicationController

  ################################################################################################
  # いいね作成
  ################################################################################################
  def create
    like = Like.new(like_post_params)
    if like.save
      like.notice_post_like(like.user_id, like.post_id)
      render status: :created, json: true
    end
  end

  ################################################################################################
  # いいね削除
  ################################################################################################
  def destroy
    liked = JSON.parse(params['like'])
    like = Like.find_by(liked)
    like.destroy!
    render status: 200, json: false
  end

  ################################################################################################
  # プライベートメソッド
  ################################################################################################
  private
    def like_post_params
      params.require(:like).permit(:user_id, :post_id)
    end

end
