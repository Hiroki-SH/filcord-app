class ApplicationController < ActionController::Base
  include SessionsHelper #login関係のメソッドを記入したヘルパーをアプリケーション内全てで使用するため

  private
    #ログイン済みのユーザか判定、未ログインの場合ログインページへリダイレクト
    def logged_in_user
      unless logged_in?
        store_location
        # flash[:danger] = "ログインをしてください"
        redirect_to login_url
      end
    end
end
