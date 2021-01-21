class V1::RelationshipsController < ApplicationController
  before_action :set_user

  # 自分自身をフォローできないように要調整
  ## if文でcurrent_userとother_userを比較すれば良いんじゃ？
  def create
    @current_user.follow(@other_user)
    @current_user.notice_follow(@current_user.id, @other_user.id)
    render json: @other_user
  end

  def destroy
    @current_user.unfollow(@other_user)
    render json: @other_user
  end
  
  # # フォロー済みかどうかを判断
  # # リファクタリング => Userモデルに移動
  # def isFollowed
  #   isFollowed = @current_user.following?(@other_user)
  #   render json: isFollowed
  # end

  private
  
  def set_user
    @current_user = User.find(params[:user_id])
    @other_user = User.find(params[:follow_id])
  end

end
