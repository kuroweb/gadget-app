class V1::LikesController < ApplicationController

  def create
    @like = Like.new(like_post_params)
    if @like.save
      render status: :created
    end
  end

  def destroy
    @like = Like.find_by(post_id: like_post_params[:post_id], user_id: like_post_params[:user_id])
  end

  private
    def like_post_params
      params.require(:like).permit(:post_id, :user_id)
    end

end
