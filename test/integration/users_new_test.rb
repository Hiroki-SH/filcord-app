require 'test_helper'

class UsersNewTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "有効なユーザを登録しようとしたとき" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post user_path, params: {
        user: {
          name: "example user",
          email: "test@example.com",
          password: "hoge",
          password_confirmation: "hoge"
        }
      }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

  test "無効なユーザを登録したとき" do
    get new_user_path
    assert_no_difference 'User.count' do
      post user_path, params: {
        user: {
          name: "",
          email: "test@example",
          password: "hoge",
          password_confirmation: "fuga"
        }
      }
    end
    assert_template 'users/new'
  end
end
