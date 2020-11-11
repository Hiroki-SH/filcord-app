module SessionsHelper
  #渡されたユーザIDでログインする(sessionにuser.idを渡す)
  def log_in(user)
    session[:user_id] = user.id
  end

  #現在ログイン中のユーザを返す（いない場合、nilを返す)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
        #id検索なのに、findではなくfind_byな理由：findでは該当するidがないとき例外を返す
        #今回はnilが欲しいので、find_byを使用
        #x ||= yは x = x || yと同義　意味は xがtrueならxに代入(つまり中身は変わらない)。xがfalseならyを代入
    end
  end

  #ログインしているユーザがいればtrue、いなければfalseを返す
  def logged_in?
    !current_user.nil?
  end

  #ログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
