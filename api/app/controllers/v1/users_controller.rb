class V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if params[:uid] 
      current_user = User.find_by(uid: params[:uid])
      render json: current_user
    else
      @users = User.all
      render json: @users
    end
  end

  def show
    render json: @user
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

  def destroy
    @user.destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :uid, :profile)
    end

    def set_user
      @user = User.find(params[:id])
    end

end
