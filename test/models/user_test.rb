require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "example name", email: "hoge@example.com")
  end

  test "有効なUserかテスト" do
    @user.valid?
  end

  # 424から
end
