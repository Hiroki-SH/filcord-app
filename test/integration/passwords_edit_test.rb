require 'test_helper'

class PasswordsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
  end

  test "現在のパスワードが間違えていて失敗するテスト" do
    log_in_as(@user)
    get edit_password_path
    assert_template 'passwords/edit'
    patch password_path, params: {
      user: {
        current_password: "wrongPassword",
        password: "hoge",
        password_confirmation: "hoge"
      } 
    }
    assert_template 'passwords/edit'
    assert_not flash.empty?
    assert_select 'div.error-explanation'
  end

  test "確認用パスワードが一致せずに失敗するテスト" do
    log_in_as(@user)
    get edit_password_path
    assert_template 'passwords/edit'
    patch password_path, params: {
      user: {
        current_password: "password",
        password: "hoge",
        password_confirmation: "fuga"
      } 
    }
    assert_template 'passwords/edit'
    assert_not flash.empty?
    assert_select 'div.error-explanation'
  end

  test "パスワードが空白により失敗するテスト" do
    log_in_as(@user)
    get edit_password_path
    assert_template 'passwords/edit'
    patch password_path, params: {
      user: {
        current_password: "password",
        password: "",
        password_confirmation: "fuga"
      } 
    }
    assert_template 'passwords/edit'
    assert_not flash.empty?
    assert_select 'div.error-explanation'
  end

  test "確認パスワードが空白により失敗するテスト" do
    log_in_as(@user)
    get edit_password_path
    assert_template 'passwords/edit'
    patch password_path, params: {
      user: {
        current_password: "password",
        password: "fuga",
        password_confirmation: ""
      } 
    }
    assert_template 'passwords/edit'
    assert_not flash.empty?
    assert_select 'div.error-explanation'
  end

  test "新パスワード2つが空白により失敗するテスト" do
    log_in_as(@user)
    get edit_password_path
    assert_template 'passwords/edit'
    patch password_path, params: {
      user: {
        current_password: "password",
        password: "",
        password_confirmation: ""
      } 
    }
    assert_template 'passwords/edit'
    assert_not flash.empty?
    assert_select 'div.error-explanation'
  end

  test "パスワードの変更に成功するテスト" do
    log_in_as(@user)
    assert is_logged_in?
    get edit_password_path
    assert_template 'passwords/edit'
    patch password_path, params: {
      user: {
        current_password: "password",
        password: "rightPassword",
        password_confirmation: "rightPassword"
      } 
    }
    assert_not flash.empty?
    follow_redirect!
    assert_template 'users/show'
    @user.reload
    delete logout_path
    assert_not is_logged_in?

    log_in_as(@user, password: 'rightPassword')
    assert is_logged_in?
  end
end
