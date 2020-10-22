class V1::UsersController < ApplicationController

def index
  @users = User.all
  render json: @users
end 
  
def create
  @user = User.new(user_params)
  if @user.save
    render json: @user, status: :created
  else
    render json: @user.errors, status: :unprocessable_entity
  end
end

private

  def user_params
    params.require(:user).permit(:name, :email, :uid, :profile)
  end

end
