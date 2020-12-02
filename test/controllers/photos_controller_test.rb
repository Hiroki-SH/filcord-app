require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:user1)
    @other_user = users(:user2)
    @photo = photos(:photo1)
    @other_user_photo = photos(:photo4)
  end

  # test "ログインせずに作成画面にリクエストしてリダイレクトされるか" do
  #   get new_photo_path
  #   assert_redirected_to login_url
  # end

  test "ログインせずに作成しようとしてリダイレクトされるか" do
    assert_no_difference 'Photo.count' do
      post photos_path, params: {
        photo: {
          f_number: "6.5",
          shutter_speed: "1/2000"
        }
      }
    end
    assert_redirected_to login_url
  end

  test "ログインせずに編集画面にリクエストしてリダイレクトされるか" do
    get edit_photo_path(@photo)
    assert_redirected_to login_url
  end

  test "ログインせずに編集しようとしてリダイレクトされるか" do
    patch photo_path(@photo), params: {
      photo: {
        f_number: "6.5",
        shutter_speed: "1/2000"
      }
    }
    assert_redirected_to login_url
  end


  test "ログインせずに削除しようとしてリダイレクトされるか" do
    assert_no_difference 'Photo.count' do
      delete photo_path(@photo)
    end
    assert_redirected_to login_url
  end

  test "違うユーザのphotoの編集画面にアクセスしてリダイレクトされるか" do
    log_in_as(@other_user)
    get edit_photo_path(@photo)
    assert_redirected_to login_url
  end

  test "違うユーザのphotoを編集しようとしてリダイレクトされるか" do
    log_in_as(@other_user)
    patch photo_path(@photo), params: {
      photo: {
        f_number: "6.5",
        shutter_speed: "1/2000"
      }
    }
    assert_redirected_to login_url
  end

  test "違うユーザのphotoを削除しようとしてリダイレクトされるか" do
    log_in_as(@other_user)
    assert_no_difference 'Photo.count' do
      delete photo_path(@photo)
    end
    assert_redirected_to login_url
  end

  test "更新後、film showにリダイレクトされるか" do
    log_in_as(@user)
    patch photo_path(@photo), params: {
      photo: {
        f_number: "6.5",
        shutter_speed: "1/2000"
      }
    }
    assert_redirected_to film_url(@photo.film_id)
  end

  test "削除後、film showにリダイレクトされるか" do
    log_in_as(@user)
    assert_difference 'Photo.count', -1 do
      delete photo_path(@photo)
    end
    assert_redirected_to film_url(@photo.film_id)
  end
end
