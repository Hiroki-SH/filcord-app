require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

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
end
