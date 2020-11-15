require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "example name", email: "hoge@example.com", 
      password: "hogehoge", password_confirmation: "hogehoge")
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
      assert @user.valid?, "#{address.inspect} は有効でなければならない" #第二引数は、エラーメッセージ表示用
    end
  end

  test "無効なメールをテスト" do
    invalid_addresses = %w[user@example,com h_Og_e_example.COM FUGA@example.
      hoge@exam_ple.jp hoge.fuga@exa+mple.cn]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} は無効でなければならない" #第二引数は、エラーメッセージ表示用
    end
  end

  test "重複するemailのUserが登録できないようにする" do
    same_user = @user.dup
    @user.save
    assert_not same_user.valid?
  end

  test "ダイジェストが存在しないときにauthenticated?がエラーにならないか" do
    assert_not @user.authenticated?('')
  end
end
