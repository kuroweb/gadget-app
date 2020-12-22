class V1::PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]

  # 投稿一覧
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      following = user.following.includes({posts: [{images_attachments: :blob},
                                                    {user: {avatar_attachment: :blob}},
                                                    :tags,
                                                    :liked_users,
                                                    {comments: [{user: {avatar_attachment: :blob}},
                                                                {images_attachments: :blob}]}]})
      posts = []
      following.each do |f|
        f.posts.each do |p|
          posts.push(p)
        end
      end
      posts.sort! do |a, b|
        b[:created_at] <=> a[:created_at]
      end
      @timeline = Kaminari.paginate_array(posts).page(params[:page]).per(5)
      render json: @timeline.as_json(include: [{user: {methods: :avatar_url}},
                                              :tags,
                                              :liked_users,
                                              {comments: {include: {user: {methods: :avatar_url}},
                                                            methods: :images_url}}],
                                      methods: :images_url)
    else
      @posts = Post.includes({images_attachments: :blob},
        {user: {avatar_attachment: :blob}},
        :tags,
        :liked_users,
        {comments: [{user: {avatar_attachment: :blob}},
                    {images_attachments: :blob}]}).page(params[:page]).per(5).order(created_at: "DESC")
      render json: @posts.as_json(include: [{user: {methods: :avatar_url}},
                            :tags,
                            :liked_users,
                            {comments: {include: {user: {methods: :avatar_url}},
                                          methods: :images_url}}],
                  methods: :images_url)
    end
  end

  # 投稿詳細
  def show
    @post = Post.includes({images_attachments: :blob},
                          {user: {avatar_attachment: :blob}},
                          :tags,
                          :liked_users,
                          {comments: [{user: {avatar_attachment: :blob}},
                                      {images_attachments: :blob}]}).find(params[:id])
    render json: @post.as_json(include: [{user: {methods: :avatar_url}},
                                          :tags,
                                          :liked_users,
                                          {comments: {include: {user: {methods: :avatar_url}},
                                                      methods: :images_url}}],
                                methods: :images_url)
  end

  # 投稿新規作成
  def create
    @post = Post.new(post_content_params)
    sent_tags = post_tags_params[:tags] === nil ? [] : post_tags_params[:tags]
    if @post.save
      @post.save_tag(sent_tags)
      render json: @post.as_json(include: [{user: {methods: :avatar_url}},
                                            :tags,
                                            :liked_users,
                                            {comments: {include: {user: {methods: :avatar_url}},
                                                        methods: :images_url}}],
                                    methods: :images_url),
              status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # 投稿更新
  def update
    sent_tags = post_tags_params[:tags] === nil ? [] : post_tags_params[:tags]
    if @post.update(post_content_params)
      @post.save_tag(sent_tags)
      # imagesが空の場合に、updateメソッドで初期化
      if post_content_params[:images] === nil
        @post.update(images: nil)
      end
      render json: @post.as_json(include: [{user: {methods: :avatar_url}},
                                            :tags,
                                            :liked_users,
                                            {comments: {include: {user: {methods: :avatar_url}},
                                                        methods: :images_url}}],
                                    methods: :images_url)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # 投稿削除
  def destroy
    @post.destroy
  end

  # 投稿検索
  def search
    if params[:post_name]
      @posts = Post.search(params[:post_name])
      render json: @posts
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_content_params
      params.require(:post).permit(:description, :user_id, images: [])
    end

    def post_tags_params
      params.require(:post).permit(tags: [])
    end
end
