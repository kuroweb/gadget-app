class V1::PostCommentsController < ApplicationController

  ################################################################################################
  # つぶやきコメント作成
  ################################################################################################
  def create
    # uidが一致する場合のみ処理を実行
    return if User.find(comment_params[:user_id]).uid != comment_params[:uid]

    @comment = PostComment.new(comment_params.except(:uid))
    if @comment.save
      @comment.notice_comment(@comment.user_id, @comment.post_id)
      render json: @comment.as_json(include: [{user: {methods: :avatar_url,
                                                      except: [:uid, :email]}},
                                              :post],
                                    methods: :images_url),
              status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  ################################################################################################
  # つぶやきコメント削除
  ################################################################################################
  def destroy
    @comment = PostComment.find_by(id: params[:comment_id])

    # uidが一致する場合のみ処理を実行
    return if @comment.user.uid != params[:uid]

    # 親コメントを削除する場合、小コメントも併せて削除する
    if params[:reply_comment_id] === nil
      child_comments = PostComment.where(reply_comment_id: params[:comment_id])
      child_comments.each do |comment|
        comment.destroy
      end
      @comment.destroy
    else
      @comment.destroy
    end
  end

  ################################################################################################
  # プライベートメソッド
  ################################################################################################
  private

    def comment_params
      comment_params = params.require(:post_comment).permit(:description, :post_id, :reply_comment_id, :user_id, :uid, images: [])
    end

end
