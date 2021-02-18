class V1::PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]

  ################################################################################################
  # 投稿一覧
  ################################################################################################
  def index
    #=============================================================================================
    # タイムライン表示 / チェック済み
    #=============================================================================================
    if params[:user_id]
      user = User.find(params[:user_id])
      following = user.following.includes({posts: [{images_attachments: :blob},
                                                    {user: {avatar_attachment: :blob}},
                                                    :tags,
                                                    :liked_users,
                                                    {post_comments: [{user: {avatar_attachment: :blob}},
                                                                {images_attachments: :blob}]}]})
      posts = []
      following.each do |f|
        f.posts.each do |p|
          posts.push(p)
        end
      end
      posts.uniq!
      posts.sort! do |a, b|
        b[:created_at] <=> a[:created_at]
      end
      @timeline = Kaminari.paginate_array(posts).page(params[:page]).per(5)
      render json: @timeline.as_json(include: [{user: {methods: :avatar_url,
                                                        except: [:uid, :email]}},
                                              :tags,
                                              {liked_users: {except: [:uid, :email]}},
                                              {post_comments: {include: {user: {methods: :avatar_url,
                                                                                except: [:uid, :email]}},
                                                          methods: :images_url}}],
                                      methods: :images_url)
    #=============================================================================================
    # タグフィード表示 / チェック済み
    #=============================================================================================
    elsif params[:tag_feed_id]
      user = User.find(params[:tag_feed_id])
      tags = user.tags.includes({posts: [{images_attachments: :blob},
                                          {user: {avatar_attachment: :blob}},
                                          :tags,
                                          :liked_users,
                                          {post_comments: [{user: {avatar_attachment: :blob}},
                                                      {images_attachments: :blob}]}]})
      posts = []
      tags.each do |tag|
        tag.posts.each do |p|
          posts.push(p)
        end
      end
      posts.uniq!
      posts.sort! do |a, b|
        b[:created_at] <=> a[:created_at]
      end
      @tag_feed = Kaminari.paginate_array(posts).page(params[:page]).per(5)
      render json: @tag_feed.as_json(include: [{user: {methods: :avatar_url,
                                                        except: [:uid, :email]}},
                                                :tags,
                                                {liked_users: {except: [:uid, :email]}},
                                                {post_comments: {include: {user: {methods: :avatar_url,
                                                                                  except: [:uid, :email]}},
                                                            methods: :images_url}}],
                                      methods: :images_url)
    #=============================================================================================
    # 特定ユーザーの投稿一覧 / チェック済み
    #=============================================================================================
    elsif params[:post_user_id]
      user = User.find(params[:post_user_id])
      posts = user.posts.includes({images_attachments: :blob},
                                  {user: {avatar_attachment: :blob}},
                                  :tags,
                                  :liked_users,
                                  {post_comments: [{user: {avatar_attachment: :blob}},
                                              {images_attachments: :blob}]}).order(created_at: 'DESC')
      user_posts = Kaminari.paginate_array(posts).page(params[:page]).per(5)
      render json: user_posts.as_json(include: [{user: {methods: :avatar_url,
                                                        except: [:uid, :email]}},
                                                :tags,
                                                {liked_users: {except: [:uid, :email]}},
                                                {post_comments: {include: {user: {methods: :avatar_url,
                                                                                  except: [:uid, :email]}},
                                                            methods: :images_url}}],
                                      methods: :images_url)
    #=============================================================================================
    # 特定ユーザーがいいねした投稿一覧 / チェック済み
    #=============================================================================================
    elsif params[:user_liked_posts_id]
      user = User.find(params[:user_liked_posts_id])
      posts = user.liked_posts.includes({images_attachments: :blob},
                                  {user: {avatar_attachment: :blob}},
                                  :tags,
                                  :liked_users,
                                  {post_comments: [{user: {avatar_attachment: :blob}},
                                              {images_attachments: :blob}]}).order(created_at: 'DESC')
      user_posts = Kaminari.paginate_array(posts).page(params[:page]).per(5)
      render json: user_posts.as_json(include: [{user: {methods: :avatar_url,
                                                        except: [:uid, :email]}},
                                                :tags,
                                                {liked_users: {except: [:uid, :email]}},
                                                {post_comments: {include: {user: {methods: :avatar_url,
                                                                                  except: [:uid, :email]}},
                                                            methods: :images_url}}],
                                      methods: :images_url)
    #=============================================================================================
    # 新着表示 / チェック済み
    #=============================================================================================
    else
      posts = Post.includes({images_attachments: :blob},
                              {user: {avatar_attachment: :blob}},
                              :tags,
                              :liked_users,
                              {post_comments: [{user: {avatar_attachment: :blob}},
                                          {images_attachments: :blob}]}).page(params[:page]).per(5).order(created_at: 'DESC')
      render json: posts.as_json(include: [{user: {methods: :avatar_url,
                                                    except: [:uid, :email]}},
                            :tags,
                            {liked_users: {except: [:uid, :email]}},
                            {post_comments: {include: {user: {methods: :avatar_url,
                                                              except: [:uid, :email]}},
                                          methods: :images_url}}],
                  methods: :images_url)
    end
  end

  ################################################################################################
  # 投稿詳細
  ################################################################################################
  def show
    @post = Post.includes({images_attachments: :blob},
                          {user: {avatar_attachment: :blob}},
                          :tags,
                          :liked_users,
                          {post_comments: [{user: {avatar_attachment: :blob}},
                                      {images_attachments: :blob}]}).find(params[:id])
    render json: @post.as_json(include: [{user: {methods: :avatar_url,
                                                  except: [:uid, :email]}},
                                          :tags,
                                          {liked_users: {except: [:uid, :email]}},
                                          {post_comments: {include: {user: {methods: :avatar_url,
                                                                            except: [:uid, :email]}},
                                                      methods: :images_url}}],
                                methods: :images_url)
  end

  ################################################################################################
  # 投稿新規作成
  ################################################################################################
  def create
    # uidが一致する場合のみ処理を実行
    return if User.find(post_content_params[:user_id]).uid != post_content_params[:uid]

    @post = Post.new(post_content_params.except(:uid))
    sent_tags = post_tags_params[:tags] === nil ? [] : post_tags_params[:tags]
    if @post.save
      @post.save_tag(sent_tags)
      render json: @post.as_json(include: [{user: {methods: :avatar_url,
                                                    except: [:uid, :email]}},
                                            :tags,
                                            {liked_users: {except: [:uid, :email]}},
                                            {post_comments: {include: {user: {methods: :avatar_url,
                                                                              except: [:uid, :email]}},
                                                        methods: :images_url}}],
                                    methods: :images_url),
              status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  ################################################################################################
  # 投稿更新
  ################################################################################################
  def update
    # uidが一致する場合のみ処理を実行
    return if @post.user.uid != post_content_params[:uid]

    sent_tags = post_tags_params[:tags] === nil ? [] : post_tags_params[:tags]
    if @post.update(post_content_params.except(:uid))
      @post.save_tag(sent_tags)
      # imagesが空の場合に、updateメソッドで初期化
      if post_content_params[:images] === nil
        @post.update(images: nil)
      end
      render json: @post.as_json(include: [{user: {methods: :avatar_url,
                                                    except: [:uid, :email]}},
                                            :tags,
                                            {liked_users: {except: [:uid, :email]}},
                                            {post_comments: {include: {user: {methods: :avatar_url,
                                                                              except: [:uid, :email]}},
                                                        methods: :images_url}}],
                                    methods: :images_url)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  ################################################################################################
  # 投稿削除
  ################################################################################################
  def destroy
    # uidが一致する場合のみ処理を実行
    return if @post.user.uid != params[:uid]

    @post.destroy
  end

  ################################################################################################
  # 投稿検索
  ################################################################################################
  def search
    if params[:post_name]
      @posts = Post.search(params[:post_name]).order(created_at: 'DESC')
      render json: @posts.as_json(include: [{user: {methods: :avatar_url,
                                                    except: [:uid, :email]}},
                                            :tags,
                                            {liked_users: {except: [:uid, :email]}},
                                            {post_comments: {include: {user: {methods: :avatar_url,
                                                                              except: [:uid, :email]}},
                                                        methods: :images_url}}],
                                    methods: :images_url)
    end
  end

  ################################################################################################
  # プライペートメソッド
  ################################################################################################
  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_content_params
      params.require(:post).permit(:description, :user_id, :uid, images: [])
    end

    def post_tags_params
      params.require(:post).permit(tags: [])
    end
end
