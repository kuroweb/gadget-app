class V1::NoticesController < ApplicationController

  ################################################################################################
  # 通知全件取得
  ################################################################################################
  def index
    user = User.find(params[:user_id])
    notices = user.passive_notices.includes({visitor: {avatar_attachment: :blob}},
                                            :visited,
                                            :post,
                                            :post_comment,
                                            :board,
                                            :board_comment).page(params[:page]).per(10).order(created_at: "DESC")
    render json: notices.as_json(include: [{visitor: {methods: :avatar_url,
                                                      except: [:uid, :email]}},
                                            :visited,
                                            :post,
                                            :board])
  end

  ################################################################################################
  # 未チェック通知数を返す
  ################################################################################################
  def unchecked
    user = User.find(params[:user_id])
    count = user.passive_notices.where(checked: false).count
    render json: count
  end

  ################################################################################################
  # 未チェック通知一覧を返す, 未チェック通知をチェック済みに変更
  ################################################################################################
  def checked
    user = User.find(params[:user_id])
    notices = user.passive_notices.where(checked: false)
    render json: notices.as_json(include: [{visitor: {methods: :avatar_url,
                                                      except: [:uid, :email]}},
                                            :visited,
                                            :post,
                                            :board])
    notices.each do |notice|
      notice.update_attributes(checked: true)
    end
  end

end
