class V1::TagsController < ApplicationController
  
  # タグ一覧
  def index
    @tags = Tag.all
    render json: @tags
  end
  
  # タグ詳細
  def show
    @tag = Tag.includes({users: {avatar_attachment: :blob}},
                        {posts: {images_attachments: :blob}},
                        {boards: {images_attachments: :blob}}).find(params[:id])
    render json: @tag.as_json(include: [{users: {methods: :avatar_url}},
                                        {posts: {methods: :images_url}},
                                        {boards: {methods: :images_url}}])
  end
  
  # タグ検索
  def search
    if params[:tag_name]
      @tags = Tag.search(params[:tag_name])
      render json: @tags
    end
  end
end
