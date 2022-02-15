class UserController < ApplicationController
  before_action :not_login, {only:[:index,:show,:edit,:update]}
  before_action :be_login, {only:[:new,:login_form,:login,:create]}
  before_action :cannot_edit, {only:[:edit,:update]}
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name],
                        email: params[:email],
                        image_name: "default_user.jpg",
                        password: params[:password]
                        )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザーを作成しました"
      redirect_to("/posts/index")
    else
      render("user/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_image/#{@user.image_name}", image.read)
    end
    if @user.save
      flash[:notice] = "ユーザー情報を変更しました"
      redirect_to("/posts/index")
    else
      render("user/edit")
    end

  end

  def login_form
    @user = User.new
  end

  def login
     @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @email = params[:email]
      @password = params[:password]
      @message = "メールアドレスかパスワードが間違っています"
      render("user/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login", status: :see_other)
  end

  def cannot_edit
    @user = User.find_by(id: params[:id])
    # if params[:id].to_i != @current_user.id
    if @current_user.id != @user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

end
