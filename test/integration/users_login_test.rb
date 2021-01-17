require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:user1)
  end

  test "誤った情報を渡したログイン処理" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {
      session: {
        email: "",
        password: ""
      }
    }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_select 'div.error-explanation'
    get root_url
    assert flash.empty?
  end

  #ログインした後の挙動のテストを書く
  test "ログインしてログアウトする" do
    get login_path
    post login_path, params: {
      session: {
        email: @user.email,
        password: "password"
      }
    }
    assert is_logged_in?
    assert_redirected_to user_path
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path #2番目のウィンドウでログアウトをクリックするユーザをシミュレートする
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "自動ログインを有効にした処理" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies[:remember_token]
  end

  test "自動ログインを無効にした処理" do
    log_in_as(@user, remember_me: '1') #cookieを保存してログイン
    delete logout_path
    log_in_as(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
  end
end
