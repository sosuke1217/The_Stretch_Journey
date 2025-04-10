class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @users = User.all
  end
  
  def deactivate
    @user = User.find(params[:id])
    @user.deactivate
    redirect_to admin_users_path, notice: 'ユーザーを非アクティブ化しました'
  end

  def activate
    @user = User.find(params[:id])
    @user.activate
    redirect_to admin_users_path, notice: 'ユーザーをアクティブ化しました'
  end
end
