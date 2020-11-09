require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "example name", email: "hoge@example.com")
  end

  test "有効なUserかテスト" do
    assert @user.valid?
  end

  test "空白の名前に対するバリデーションが機能するかテスト" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "空白のメールに対するバリデーションが機能するかテスト" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "65文字以上の名前に対するテスト" do
    @user.name = "a" * 65
    assert_not @user.valid?
  end

  test "256文字以上の名前に対するテスト" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "有効なメールをテスト" do
    valid_addresses = %w[user@example.com h_Og_e@example.COM FUGA@example.org
      hoge@example.jp hoge.fuga@example.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid? "#{address.inspect} should be valid" #第二引数は、エラーメッセージ表示用
    end
  end
end
