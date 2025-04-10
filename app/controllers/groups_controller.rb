class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :reject_without_join_user, only: [:leave]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.members.includes(:group_users)
    @users = @users.where('group_users.is_approved': true) unless @group.is_owned_by?(current_user)
    @group_comments = @group.group_comments
    
    @group_user = GroupUser.find_by(group_id: @group.id, user_id: current_user.id)
    @group_comment = GroupComment.new
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to groups_path
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to groups_path
  end

  def all_destroy
    @group = Group.find(params[:group_id])
    if @group.destroy
    redirect_to groups_path
    end
  end

  def join
    group = Group.find(params[:id])
    current_user.group_users.create(group: group)
    redirect_to group_path(group), notice: '参加リクエストを送信しました'
  end

  def approve_request
    group = Group.find(params[:id])
    user = User.find(params[:user_id])
    user.group_users.find_by(group: group).update(is_approved: true)
    redirect_to group_path(group), notice: '参加リクエストを承認しました'
  end

  def revoke_request
    group = Group.find(params[:id])
    user = User.find(params[:user_id])
    user.group_users.find_by(group: group).update(is_approved: false)
    redirect_to group_path(group), notice: '参加リクエストを取り消しました'
  end

  def leave
    @group = Group.find(params[:id])
    @group.members.delete(current_user)
    redirect_to group_path(@group), notice: 'グループから退会しました'
  end
  
  private

  def group_params
    params.require(:group).permit(:name, :introduction)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

  def reject_without_join_user
    @group = Group.find(params[:id])
    redirect_to root_url unless @group.members.include?(current_user)
  end
end
