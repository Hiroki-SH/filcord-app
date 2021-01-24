class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new(session[:user] || {})
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user] = nil
      log_in(@user)
      flash[:success] = "ユーザーを登録しました"
      redirect_to user_url
    else
      flash[:danger] = "ユーザーの登録に失敗しました"
      flash[:validation_error] = @user.errors.full_messages
      session[:user] = @user.attributes.slice(*user_params.keys) #sessionにフォームで入力された値のみ保存
      redirect_to new_user_url
    end
  end

  def show
    @films = current_user.films.paginate(page: params[:page])
  end

  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update
    @user = User.find_by(id: current_user.id)
    if @user.update(user_params)
      flash[:success] = "ユーザーを更新しました"
      redirect_to user_url
    else
      flash[:danger] = "ユーザーの更新に失敗しました"
      flash[:validation_error] = @user.errors.full_messages
      redirect_to edit_user_url
    end
  end

  def destroy
    User.find(current_user.id).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to login_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
