class V1::CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destory

  end

  private

    def comment_params
      comment_params = params.require(:comment).permit(:description, :post_id, :reply_comment_id, :user_id)
    end

end
