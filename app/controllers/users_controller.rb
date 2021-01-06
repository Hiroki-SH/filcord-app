class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      # flash[:success] = "新しいフィルムを登録しました！"
      redirect_to user_url
    else
      render :new
    end
  end

  def show
    @films = current_user.films.paginate(page: params[:page])
  end

  def edit
    # @user = User.find_by(id: current_user.id)
  end

  def update
    @user = User.find_by(id: current_user.id)
    # debugger
    if @user.update(user_params)
      # flash[:success] = "フィルム情報を更新しました！"
      redirect_to user_url
    else
      render :edit
    end
  end

  def destroy
    User.find(current_user.id).destroy
    # flash[:success] = "ユーザーを削除しました！"
    redirect_to login_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
