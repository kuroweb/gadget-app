class V1::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :update_avatar, :destroy, :following, :followers, :posts]

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
    render json: @user.as_json(include: [{following: {except: [:uid, :email]}},
                                          {followers: {except: [:uid, :email]}},
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
                                except: [:uid])
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
    # uidが一致する場合のみ処理を実行
    return if @user.uid != user_params[:uid]

    @user.update(user_params.except(:uid))
    render json: @user
  end

  ################################################################################################
  # アバター更新
  ################################################################################################
  def update_avatar
    # uidが一致する場合のみ処理を実行
    return if @user.uid != params[:uid]

    @user.avatar.attach(params[:avatar])
    render json: @user
  end

  ################################################################################################
  # ユーザー削除
  ################################################################################################
  def destroy
    # ゲストユーザーは削除できない
    return if @user.guest == true
    
    # uidが一致する場合のみ処理を実行
    return if @user.uid != params[:uid]

    @user.destroy
  end

  ################################################################################################
  # ユーザー検索
  ################################################################################################
  def search
    if params[:user_name]
      users = User.includes({avatar_attachment: :blob},
                              :followers).search(params[:user_name])
      render json: users.as_json(include: {followers: {except: [:uid, :email]}},
                                  methods: :avatar_url,
                                  except: [:uid, :email])
    end
  end

  ################################################################################################
  # ゲストモードの切り替え（管理者専用）
  ################################################################################################
  def guestmode
    # 管理者パスワードと照合できた場合のみ処理を実行
    return if ENV['USER_ADMIN_PASS'] != params[:user_admin_pass]

    user = User.find(params[:id])
    user.guest = !user.guest
    user.save

    render json: "name: #{user.name}, guestmode: #{user.guest}, adminmode: #{user.admin}"
  end

  ################################################################################################
  # 管理者モードの切り替え（管理者専用）
  ################################################################################################
  def adminmode
    # 管理者パスワードと照合できた場合のみ処理を実行
    return if ENV['USER_ADMIN_PASS'] != params[:user_admin_pass]

    user = User.find(params[:id])
    user.admin = !user.admin
    user.save

    render json: "name: #{user.name}, guestmode: #{user.guest}, adminmode: #{user.admin}"
  end

  ################################################################################################
  # ユーザー情報を取得（管理者専用）
  ################################################################################################
  def userinfo
    # 管理者パスワードと照合できた場合のみ処理を実行
    return if ENV['USER_ADMIN_PASS'] != params[:user_admin_pass]

    user = User.find(params[:id])

    render json: "name: #{user.name}, email: #{user.email}, uid: #{user.uid}, guestmode: #{user.guest}, adminmode: #{user.admin}"
  end
  
  ################################################################################################
  # ユーザーを削除（管理者専用）
  ################################################################################################
  def userdelete
    # 管理者パスワードと照合できた場合のみ処理を実行
    return if ENV['USER_ADMIN_PASS'] != params[:user_admin_pass]

    user = User.find(params[:id])
    user.destroy

    render json: "name: #{user.name}, email: #{user.email}, uid: #{user.uid}, guestmode: #{user.guest}, adminmode: #{user.admin}"
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
