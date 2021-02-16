class V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers, :posts]

  ################################################################################################
  # ユーザー一覧
  ################################################################################################
  def index
    #=============================================================================================
    # ログイン処理で必要な値を返す
    #=============================================================================================
    if params[:uid] 
      current_user = User.with_attached_avatar.find_by(uid: params[:uid])
      render json: current_user.as_json(methods: :avatar_url)
    #=============================================================================================
    # ユーザー全件を返す
    #=============================================================================================
    else
      @users = User.all
      render json: @users
    end
  end

  ################################################################################################
  # ユーザー詳細
  ################################################################################################
  def show
    @user = User.includes({avatar_attachment: :blob},
                          :following,
                          :followers,
                          {gadgets: [{images_attachments: :blob},
                                    :tags,
                                    {user: {avatar_attachment: :blob}}]},
                          {posts: [{images_attachments: :blob},
                                    :tags,
                                    :liked_users,
                                    {user: {avatar_attachment: :blob}},
                                    {post_comments: [{user: {avatar_attachment: :blob}},
                                                {images_attachments: :blob}]}]}).find(params[:id])
    render json: @user.as_json(include: [:following,
                                          :followers,
                                          {gadgets: {include: [:tags,
                                                              {user: {methods: :avatar_url,
                                                                      except: [:uid, :email]}}],
                                                      methods: :images_url}},
                                          {posts: {include: [:tags,
                                                              {liked_users: {except: [:uid, :email]}},
                                                              {user: {methods: :avatar_url,
                                                                      except: [:uid, :email]}},
                                                              {post_comments: {include: {user: {methods: :avatar_url,
                                                                                                except: [:uid, :email]}},
                                                                          methods: :images_url}}],
                                                    methods: :images_url}}],
                                methods: :avatar_url,
                                except: [:uid, :email])
  end

  ################################################################################################
  # ユーザー新規作成
  ################################################################################################
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  ################################################################################################
  # ユーザー更新
  ################################################################################################
  def update
    if @user.update(user_params)
      render json: @user
    end
  end

  ################################################################################################
  # ゲストモードの有効化
  ################################################################################################
  # def guestmode
  #   user = User.find(params[:id])
  #   user.guest = true
  #   user.save
  # end

  ################################################################################################
  # アバター更新
  ################################################################################################
  def update_avatar
    @user = User.find(params[:id])
    @user.avatar.attach(params[:avatar])
    render json: @user
  end

  ################################################################################################
  # ユーザー削除
  ################################################################################################
  def destroy
    @user.destroy
  end

  ################################################################################################
  # ユーザー検索
  ################################################################################################
  def search
    if params[:user_name]
      @users = User.includes({avatar_attachment: :blob},
                              :followers).search(params[:user_name])
      render json: @users.as_json(include: :followers,
                                  methods: :avatar_url)
    end
  end

  ################################################################################################
  # プライペートメソッド
  ################################################################################################
  private
    def user_params
      params.require(:user).permit(:name, :email, :uid, :profile, :avatar)
    end

    def set_user
      @user = User.find(params[:id])
    end

end
