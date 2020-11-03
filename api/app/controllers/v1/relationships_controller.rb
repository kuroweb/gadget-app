class V1::RelationshipsController < ApplicationController
  before_action :set_user

  def create
    @current_user.follow(@other_user)
    render json: @other_user
  end

  def destroy
    @current_user.unfollow(@other_user)
    render json: @other_user
  end
  
  # フォロー済みかどうかを判断
  def isFollowed
    isFollowed = @current_user.following?(@other_user)
    render json: isFollowed
  end


  private
  
  # front側から送られるパラメータでユーザーをセット
  def set_user
    @current_user = User.find(params[:user_id])
    @other_user = User.find(params[:follow_id])
  end

end
