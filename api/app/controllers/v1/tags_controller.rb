class V1::TagsController < ApplicationController
  
  ################################################################################################
  # タグ一覧
  ################################################################################################
  def index
    @tags = Tag.all
    render json: @tags
  end
  
  ################################################################################################
  # タグ詳細
  ################################################################################################
  def show
    @tag = Tag.includes({users: {avatar_attachment: :blob}},
                        {posts: [{images_attachments: :blob},
                                  :tags,
                                  {user: {avatar_attachment: :blob}}]},
                        {boards: [{images_attachments: :blob},
                                  :tags,
                                  {user: {avatar_attachment: :blob}}]},
                        {gadgets: [{images_attachments: :blob},
                                  :tags,
                                  {user: {avatar_attachment: :blob}}]}).find(params[:id])
    render json: @tag.as_json(include: [{users: {methods: :avatar_url,
                                                  except: [:uid, :email]}},
                                        {posts: {methods: :images_url,
                                                  include: [:tags,
                                                            {user: {methods: :avatar_url,
                                                                    except: [:uid, :email]}}]}},
                                        {boards: {methods: :images_url,
                                                  include: [:tags,
                                                            {user: {methods: :avatar_url,
                                                                    except: [:uid, :email]}}]}},
                                        {gadgets: {methods: :images_url,
                                                  include: [:tags,
                                                            {user: {methods: :avatar_url,
                                                                    except: [:uid, :email]}}]}}])
  end
  
  ################################################################################################
  # タグ検索
  ################################################################################################
  def search
    if params[:tag_name]
      @tags = Tag.includes({users: {avatar_attachment: :blob}},
                            {posts: {images_attachments: :blob}},
                            {boards: {images_attachments: :blob}},
                            {gadgets: {images_attachments: :blob}}).search(params[:tag_name])
      render json: @tags.as_json(include: [{users: {methods: :avatar_url,
                                                    except: [:uid, :email]}},
                                            {posts: {methods: :images_url}},
                                            {boards: {methods: :images_url}},
                                            {gadgets: {methods: :images_url}}])
    end
  end
end
