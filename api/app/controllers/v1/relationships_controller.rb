class V1::RelationshipsController < ApplicationController
  before_action :set_user

  ################################################################################################
  # フォローする
  ################################################################################################
  def create
    @current_user.follow(@other_user)
    @current_user.notice_follow(@current_user.id, @other_user.id)
    render json: @other_user
  end

  ################################################################################################
  # フォローを解除する
  ################################################################################################
  def destroy
    @current_user.unfollow(@other_user)
    render json: @other_user
  end

  ################################################################################################
  # プライペートメソッド
  ################################################################################################
  private
    def set_user
      @current_user = User.find(params[:user_id])
      @other_user = User.find(params[:follow_id])
    end
    
end
