class GroupUsersController < ApplicationController
  def update
    @group_user = GroupUser.find(params[:id])
    if @group_user.update(group_user_params)
      redirect_to @group_user.group, notice: "ユーザーの承認状況を更新しました。"
    else
      render :edit
    end
  end
  
  def unapprove_member
    @group_user = GroupUser.find(params[:id])
    @group_user.update(is_approved: false)
    redirect_to @group_user.group, notice: "ユーザーの申請を解除しました。"
  end

  private

  def group_user_params
    params.require(:group_user).permit(:is_approved)
  end
end
