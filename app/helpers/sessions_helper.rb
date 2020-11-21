module SessionsHelper
  #渡されたユーザIDでログインする(sessionにuser.idを渡す)
  def log_in(user)
    session[:user_id] = user.id
  end

  #ユーザのセッションを永続的にする
  def remember(user)
    user.remember #トークンの作成とトークンダイジェストをデータベースに保存
    cookies.permanent.signed[:user_id] = user.id #cookiesに署名・暗号化、有効期間20年でuser idを保存
    cookies.permanent[:remember_token] = user.remember_token #cookiesに有効期間20年でuser remember_tokenを保存
  end


  #現在ログイン中のユーザを返す（いない場合、nilを返す)
  def current_user
    if (user_id = session[:user_id]) #ブラウザ保存のセッションがあればuser_idに代入
      @current_user ||= User.find_by(id: user_id)
        #id検索なのに、findではなくfind_byな理由：findでは該当するidがないとき例外を返す
        #今回はnilが欲しいので、find_byを使用
        #x ||= yは x = x || yと同義　意味は xがtrueならxに代入(つまり中身は変わらない)。xがfalseならyを代入
    elsif (user_id = cookies.signed[:user_id]) #ブラウザ保存のcookieがあればuser_idに代入
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token]) #ユーザが存在するかつ、cookieのトークンとuserに保存されたトークンが等しい
        log_in user
        @current_user = user
      end
    end
  end

  #ログインしているユーザがいればtrue、いなければfalseを返す
  def logged_in?
    !current_user.nil?
  end

  #ブラウザのcookieからidとtokenを削除する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  #ログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  #規則したURLかデフォルトURLにリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  #URLを記憶
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
