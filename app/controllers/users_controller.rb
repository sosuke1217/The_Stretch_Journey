class UsersController < ApplicationController
  def show
      @user = User.find(params[:id])
      @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'プロフィールを更新しました。'
    else
      render :edit
    end
  end

  def deactivate
    @user = User.find(params[:id])
    @user.deactivate
    redirect_to @user, notice: 'ユーザーを非アクティブ化しました'
  end
  
  def activate
    @user = User.find(params[:id])
    @user.activate
    redirect_to @user, notice: 'ユーザーをアクティブ化しました'
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email)
  end
end
