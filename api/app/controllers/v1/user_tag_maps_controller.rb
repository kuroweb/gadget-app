class V1::UserTagMapsController < ApplicationController

  ################################################################################################
  # タグをフォロー
  ################################################################################################
  def create
    # uidが一致する場合のみ処理を実行
    return if User.find(follow_tag_params[:user_id]).uid != follow_tag_params[:uid]

    follow_tag = UserTagMap.new(follow_tag_params.except(:uid))
    if follow_tag.save
      render status: :created, json: true
    end
  end

  ################################################################################################
  # タグをフォロー解除
  ################################################################################################
  def destroy
    follow_tag = UserTagMap.find_by(user_id: params[:user_id], tag_id: params[:tag_id])

    # uidが一致する場合のみ処理を実行
    return if follow_tag.user.uid != params[:uid]

    follow_tag.destroy
    render status: 200, json: false
  end

  ################################################################################################
  # プライベートメソッド
  ################################################################################################
  private
    def follow_tag_params
      params.require(:follow_tag).permit(:user_id, :tag_id, :uid)
    end
end
