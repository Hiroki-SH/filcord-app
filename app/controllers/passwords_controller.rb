class PasswordsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update
    @user = User.find_by(id: current_user.id)
    if @user.authenticate(params[:user][:current_password])

      if params[:user][:password].empty? or params[:user][:password_confirmation].empty?
        flash[:danger] = "パスワードの変更に失敗しました"
        @user.errors.clear
        @user.errors.add(:base, '新パスワードと新パスワード(確認)の両方を入力してください')
        error_redirect
      elsif @user.update(user_params)
        flash[:success] = "パスワードを変更しました"
        redirect_to user_url
      else
        flash[:danger] = "パスワードの変更に失敗しました"
        @user.errors.clear
        @user.errors.add(:base, '新パスワードと新パスワード(確認)の入力が一致していません')
        error_redirect
      end

    else
      flash[:danger] = "パスワードの変更に失敗しました"
      params[:user][:current_password].empty? ? 
        @user.errors.add(:base, '今のパスワードを入力してください') : 
        @user.errors.add(:base, '今のパスワードが違います')
      error_redirect
    end

  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def error_redirect
      flash[:validation_error] = @user.errors.full_messages
      redirect_to edit_password_url
    end
end
