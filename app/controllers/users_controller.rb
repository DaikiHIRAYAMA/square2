class UsersController < ApplicationController
  before_action :correct_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

private

  def current_user?(user) #helperに書いても反応しなかったので、ここに直接書き込みました。
    user == current_user
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to current_user unless current_user?(@user)
  end

end
