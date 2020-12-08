class V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers, :posts]

  def index
    if params[:uid] 
      @current_user = User.find_by(uid: params[:uid])
      render json: @current_user, include: []
    else
      @users = User.all
      render json: @users, include: []
    end
  end

  # ユーザー詳細ページに必要な情報をインクルードして返す。
  def show
    @user = User.with_attached_avatar.includes(:following, :followers).find(params[:id])
    posts = @user.posts.with_attached_images.order(created_at: 'DESC').includes(:user, :tags, :liked_users, :comments)
    render json: {
      user: @user.as_json(methods: :avatar_url, include: [:following, :followers]),
      posts: posts.as_json(methods: :images_url, include: [{user: {methods: :avatar_url}}, :tags, :liked_users, {comments: {include: {user: {methods: :avatar_url}}}}])
    }
  end

  def test

  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    end
  end

  def update_avatar
    @user = User.find(params[:id])
    @user.avatar.attach(params[:avatar])
    render json: @user
  end

  def destroy
    @user.destroy
  end

  def following
    render json: @user.following, include: []
  end

  def followers
    render json: @user.followers, include: []
  end

  def isFollowed
    @current_user = User.find(params[:current_user])
    @other_user = User.find(params[:other_user])
    isFollowed = @current_user.following?(@other_user)
    render json: isFollowed
  end

  def posts
    render json: @user, include: [:posts]
  end

  def search
    if params[:user_name]
      @users = User.search(params[:user_name])
      render json: @users
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :uid, :profile, :avatar)
    end

    def set_user
      @user = User.find(params[:id])
    end

end
