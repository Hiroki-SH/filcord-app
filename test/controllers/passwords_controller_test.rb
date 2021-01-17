require 'test_helper'

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
  end

  test "edit getできるか" do
    log_in_as(@user)
    get edit_password_path
    assert_response :success
  end

  test "ログインせずにeditをリクエストとしてリダイレクトされるか" do
    get edit_password_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインせずにupdateしようとしてリダイレクトされるか" do
    patch password_path, params: {
      user: {
        current_password: "password",
        password: "hoge",
        password_confirmation: "hoge"
      } 
    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

end
