class V1::NoticesController < ApplicationController

  def index
    user = User.find(params[:user_id])
    notices = user.passive_notices.all
    notices.where(checked: false).each do |notice|
      notice.update_attributes(checked: true)
    end
    render json: notices
  end

  def unchecked
    user = User.find(params[:user_id])
    count = user.passive_notices.where(checked: false).count
    render json: count
  end

  def checked
    user = User.find(params[:user_id])
    notices = user.passive_notices.where(checked: false)
    render json: notices.as_json(include: [{visitor: {methods: :avatar_url}},
                                            :visited,
                                            :post,
                                            :board])
    notices.each do |notice|
      notice.update_attributes(checked: true)
    end
  end

end
