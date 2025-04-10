class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :guest_login
  
  def show
      @user = User.find(params[:id])
      @posts = @user.posts
      @groups = @user.owner_groups
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

  def guest_login
    @user = User.guest
    sign_in(@user)
    redirect_to after_sign_in_path_for(@user)
   end   

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email)
  end
end
