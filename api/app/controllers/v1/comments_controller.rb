class V1::CommentsController < ApplicationController
  # reply_comment_id有のデータを登録する場合に、Comment.find_by(id: reply_comment_id)が存在するのか確認するバリデーションが必要。
  # -> 親コメントを削除した状態で別の人が返信コメントを作成した場合に、画面上で描画されないバグが発生するから。

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment.as_json(include: [{user: {methods: :avatar_url}},
                                              :post],
                                    methods: :images_url),
              status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:comment_id])
    # 親コメントを削除する場合、小コメントも併せて削除する
    if params[:reply_comment_id] === nil
      child_comments = Comment.where(reply_comment_id: params[:comment_id])
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
      comment_params = params.require(:comment).permit(:description, :post_id, :reply_comment_id, :user_id, images: [])
    end

end
