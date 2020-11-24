require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @film = films(:film1)
    @photo = @film.photos.build(f_number: "2.8", shutter_speed: "1/125")
  end

  test "有効なFilmかどうかテスト" do
    assert @photo.valid?
  end

  test "film_id(外部キー)がnilのとき無効なフィルムになるか" do
    @photo.film_id = nil
    assert_not @photo.valid?
  end

  test "空白の絞り値に対するバリデーションが機能するかテスト" do
    @photo.f_number = "     "
    assert_not @photo.valid?
  end

  test "空白のシャッタースピードに対するバリデーションが機能するかテスト" do
    @photo.shutter_speed = "     "
    assert_not @photo.valid?
  end
end
