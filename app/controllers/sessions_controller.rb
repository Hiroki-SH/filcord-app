class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      session[:user] = nil #ユーザ登録で保存されていたセッションを削除
      params[:session][:remember_me] == '1' ?  remember(@user) : forget(@user)
      flash[:success] = "ログインしました"
      redirect_back_or(user_url)
    else
      @user = User.new
      flash[:danger] = "ログインに失敗しました" 
      @user.errors.add(:base, 'Emailアドレスとパスワードの入力に誤りがあります')
      flash[:validation_error] = @user.errors.full_messages
      redirect_to login_url
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end
end
