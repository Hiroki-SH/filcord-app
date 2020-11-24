require 'test_helper'

class FilmTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:user1)
    @film = @user.films.build(name: "example_name", iso: "100")
  end

  test "有効なFilmかどうかテスト" do
    assert @film.valid?
  end

  test "空白の名前に対するバリデーションが機能するかテスト" do
    @film.name = "     "
    assert_not @film.valid?
  end

  test "空白のisomに対するバリデーションが機能するかテスト" do
    @film.iso = "      "
    assert_not @film.valid?
  end

  test "長すぎる名前に対するバリデーションが機能するかテスト" do
    @film.name = "a" * 128
    assert_not @film.valid?
  end

  test "fixture内の日付が一番新しいFilmとデータベースの最初のFilmが同じか" do
    assert_equal films(:film3), Film.first
  end
end
