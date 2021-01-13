require 'test_helper'

class PhotosNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
    @film = films(:film1)
  end

  test "photoの追加(new)に失敗するテスト" do
    log_in_as(@user)
    get new_photo_path
    assert_template 'photos/new'
    post photos_path, params: {
      photo: {
        f_number: "",
        shutter_speed: ""
      },
      film_id: @film.id
    }
    assert_template 'photos/new'
    assert_not flash.empty?
    assert_select 'div.error-explanation'
  end

  test "photoの追加(new)に成功するテスト" do
    log_in_as(@user)
    get new_photo_path
    assert_template 'photos/new'

    f_number = "8"
    shutter_speed = "1/200"
    post photos_path, params: {
      photo: {
        f_number: f_number,
        shutter_speed: shutter_speed
      },
      film_id: @film.id
    }

    assert_not flash.empty?
    follow_redirect!
    assert_template 'films/show'
    assert_match f_number, response.body
    assert_match shutter_speed, response.body
  end
end
