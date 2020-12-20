class V1::BoardCommentsController < ApplicationController

  def create
    @comment = BoardComment.new(comment_params)
    if @comment.save
      render json: @comment.as_json(include: [{user: {methods: :avatar_url}},
                                              :board],
                                    methods: :images_url),
              status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = BoardComment.find_by(id: params[:comment_id])
    # 親コメントを削除する場合、小コメントも併せて削除する
    if params[:reply_comment_id] === nil
      child_comments = BoardComment.where(reply_comment_id: params[:comment_id])
      child_comments.each do |comment|
        comment.destroy
      end
      @comment.destroy
    else
      @comment.destroy
    end
  end

  private

    def comment_params
      comment_params = params.require(:board_comment).permit(:description, :board_id, :reply_comment_id, :user_id, images: [])
    end

end
