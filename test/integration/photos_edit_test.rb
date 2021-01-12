require 'test_helper'

class PhotosEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
    @other_user = users(:user2)
    @photo = photos(:photo1)
    @other_user_photo = photos(:photo4)
  end

  test "photoの編集(edit)に失敗するテスト" do
    log_in_as(@user)
    get edit_photo_path(@photo)
    assert_template 'photos/edit'
    patch photo_path(@photo), params: {
      photo: {
        f_number: "",
        shutter_speed: ""
      }
    }
    assert_template 'photos/edit'
    assert_not flash.empty?
    assert_select 'div.error-explanation'
  end

  test "photoの編集に成功するテスト" do
    #フレンドリーフォワーディングのテスト
    log_in_as(@user)
    get edit_photo_path(@other_user_photo)
    assert_redirected_to login_url
    log_in_as(@other_user)
    assert_redirected_to edit_photo_path(@other_user_photo)

    f_number = "6.5"
    shutter_speed = "1/2000"
    patch photo_path(@other_user_photo), params: {
      photo: {
        f_number: f_number,
        shutter_speed: shutter_speed
      }
    }
    assert_not flash.empty?
    assert_redirected_to film_url(@other_user_photo.film_id)
    @other_user_photo.reload
    assert_equal f_number, @other_user_photo.f_number
    assert_equal shutter_speed, @other_user_photo.shutter_speed
  end
end
