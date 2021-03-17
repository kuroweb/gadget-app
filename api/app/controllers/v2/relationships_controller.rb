class V2::RelationshipsController < ApplicationController
  before_action :set_user

  ################################################################################################
  # フォローする
  ################################################################################################
  def create
    # uidが一致する場合のみ処理を実行
    return if @current_user.uid != params[:uid]

    @current_user.follow(@other_user)
    @current_user.notice_follow(@current_user.id, @other_user.id)
    render json: @other_user
  end

  ################################################################################################
  # フォローを解除する
  ################################################################################################
  def destroy
    # uidが一致する場合のみ処理を実行
    return if @current_user.uid != params[:uid]

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
