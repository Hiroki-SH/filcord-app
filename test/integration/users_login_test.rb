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
    # assert_not flash.empty?
    # get root_url
    # assert flash.empty?
  end

  #ログインした後の挙動のテストを書く

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
