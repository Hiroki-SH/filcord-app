require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
    @other_user = users(:user2)
  end

  test "show getできるか" do
    log_in_as(@user)
    get user_path
    assert_response :success
  end

  test "new getできるか" do
    get new_user_path
    assert_response :success
  end

  test "edit getできるか" do
    log_in_as(@user)
    get edit_user_path
    assert_response :success
  end

  test "ログインせずにshowをリクエストしてリダイレクトされるか" do
    get user_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインせずにユーザ編集画面をリクエストしてリダイレクトされるか" do
    get edit_user_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインせずにユーザ編集しようとしてリダイレクトされるか" do
    patch user_path, params: {
      user: {
        name: @user.name,
        email: @user.email
      }
    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインせずにユーザ削除しようとしてリダイレクトされるか" do
    delete user_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

end
