class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: '投稿が作成されました。'
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @active_users_posts = Post.active_users_posts
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: '投稿を削除しました。'
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def deactivate_user
    user = User.find(params[:id])
    user.deactivate
    redirect_to users_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
