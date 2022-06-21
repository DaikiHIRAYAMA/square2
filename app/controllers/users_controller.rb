class UsersController < ApplicationController
   #before_action :correct_user, only: [:show]
   before_action :authenticate_user!
   before_action :correct_user_show , only: [:show]
   

  def index
    @users = User.all
  end

  def show
  end

private

  def current_user?(user) #helperに書いても反応しなかったので、ここに直接書き込みました。
    user == current_user
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to current_user unless current_user?(@user)
  end

  def correct_user_show
    @user = User.find(params[:id])
    redirect_to mypage_path if current_user?(@user)
  end
  
end
