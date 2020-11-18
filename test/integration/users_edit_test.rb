require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
  end

  test "userの編集(edit)に失敗するテスト" do
    log_in_as(@user)
    get edit_user_path
    assert_template 'users/edit'
    patch user_path, params: { 
      user: {
        name: "",
        email: "test@example,com",
        password: "hoge",
        password_confirmation: "fuga"
      }
    }
    assert_template 'users/edit'
  end

  test "userの編集(edit)に成功するテスト" do
    log_in_as(@user)
    get edit_user_path
    assert_template 'users/edit'
    patch user_path, params: { 
      user: {
        name: "test_edit",
        email: "test_edit@example.com",
        password: "",
        password_confirmation: ""
      }
    }
    follow_redirect!
    assert_template 'users/show'
  end
end
