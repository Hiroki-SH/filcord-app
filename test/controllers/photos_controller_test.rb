require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @photo = photos(:photo1)
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
end
