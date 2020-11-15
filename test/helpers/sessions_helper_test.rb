require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  
  def setup
    @user = users(:user1)
    remember(@user)
  end

  test "現在ログイン中のユーザがcurrent_userと同じになるか" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "cookieとデータベースのトークンが一致していないとき、current_userはnilになるか" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end