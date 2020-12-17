class V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers, :posts]

  def index
    if params[:uid] 
      @current_user = User.with_attached_avatar.find_by(uid: params[:uid])
      render json: @current_user.as_json(methods: :avatar_url)
    else
      @users = User.all
      render json: @users
    end
  end

  def show
    @user = User.includes({avatar_attachment: :blob},
                          :following,
                          :followers,
                          {posts: [{images_attachments: :blob},
                                    :tags,
                                    :liked_users,
                                    {user: {avatar_attachment: :blob}},
                                    {comments: [{user: {avatar_attachment: :blob}},
                                                {images_attachments: :blob}]}]}).find(params[:id])
    render json: @user.as_json(include: [:following,
                                          :followers,
                                          {posts: {include: [:tags,
                                                              :liked_users,
                                                              {user: {methods: :avatar_url}},
                                                              {comments: {include: {user: {methods: :avatar_url}},
                                                                          methods: :images_url}}],
                                                    methods: :images_url}}],
                                methods: :avatar_url)
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
    render json: @user.following
  end

  def followers
    render json: @user.followers
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
