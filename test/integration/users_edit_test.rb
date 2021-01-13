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
    assert_not flash.empty?
    assert_select 'div.error-explanation'
  end

  test "userの編集(edit)に成功するテスト" do
    log_in_as(@user)
    get edit_user_path
    assert_template 'users/edit'

    name = "test_edit"
    email = "test_edit@example.com"
    patch user_path, params: { 
      user: {
        name: name,
        email: email,
        password: "",
        password_confirmation: ""
      }
    }
    assert_not flash.empty?
    follow_redirect!
    assert_template 'users/show'
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
