class PostsController < ApplicationController
  before_action :not_login
  before_action :not_edit, {only:[:edit,:update,:destroy]}

  def index
    @posts = Post.all.order(id: :desc)
  end

  def new
      @post = Post.new
    end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes = @post.likes.count
  end

  def create
    @post = Post.create(content: params[:content], user_id: @current_user.id)
    if @post.save
      flash[:notice] = "投稿を作成しました。"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました。"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index", status: :see_other)
  end

  def not_edit
    @post = Post.find_by(id: params[:id])
    if @current_user.id != @post.user_id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
