class GroupCommentsController < ApplicationController

  def create
    group = Group.find(params[:group_id])
    group_comment = current_user.group_comments.new(group_comment_params)
    group_comment.group_id = group.id
    if group_comment.save
      redirect_to group_path(group), notice: 'コメントが投稿されました'
    else
      render 'groups/show'
    end
  end

  def destroy
    GroupComment.find(params[:id]).destroy
    redirect_to group_path(params[:group_id]), notice: 'コメントが削除されました'
  end

  private

  def group_comment_params
    params.require(:group_comment).permit(:body, :user_id)
  end
end