class V1::UserTagMapsController < ApplicationController
  # タグフォロー機能
  def create
    @follow_tag = UserTagMap.new(follow_tag_params)
    if @follow_tag.save
      render status: :created, json: true
    end
  end

  def destroy
    follow_tag = JSON.parse(params['follow_tag'])
    @followed_tag = UserTagMap.find_by(follow_tag)
    @followed_tag.destroy!
    render status: 200, json: false
  end

  private
    def follow_tag_params
      params.require(:follow_tag).permit(:user_id, :tag_id)
    end
end
