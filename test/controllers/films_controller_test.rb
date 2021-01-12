require 'test_helper'

class FilmsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
    @film = films(:film1)
    @other_user_film = films(:film4)
  end

  test "show getできるか" do
    log_in_as(@user)
    get film_path(@film)
    assert_response :success
  end

  test "new getできるか" do
    log_in_as(@user)
    get new_film_path
    assert_response :success
  end

  test "edit getできるか" do
    log_in_as(@user)
    get edit_film_path(@film)
    assert_response :success
  end

  test "ログインせずにフィルム詳細画面にリクエストしてリダイレクトされるか" do
    get film_path(@film)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインせずに作成画面にリクエストしてリダイレクトされるか" do
    get new_film_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインせずに作成しようとしてリダイレクトされるか" do
    assert_no_difference 'Film.count' do
      post films_path, params: {
        film: {
          name: "example name",
          company: "example company",
          iso: "100"
        }
      }
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインせずに編集画面にリクエストしてリダイレクトされるか" do
    get edit_film_path(@film)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインせずに編集しようとしてリダイレクトされるか" do
    patch film_path(@film), params: {
      film: {
        name: "example name",
        company: "example company",
        iso: "100"
      }
    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end


  test "ログインせずに削除しようとしてリダイレクトされるか" do
    assert_no_difference 'Film.count' do
      delete film_path(@film)
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "違うユーザのフィルム詳細画面にリクエストしてリダイレクトされるか" do
    log_in_as(@user)
    get film_path(@other_user_film)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "違うユーザのフィルム編集画面にリクエストしてリダイレクトされるか" do
    log_in_as(@user)
    get edit_film_path(@other_user_film)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "違うユーザのフィルムを編集しようとしてリダイレクトされるか" do
    log_in_as(@user)
    patch film_path(@other_user_film), params: {
      film: {
        name: "example name",
        company: "example company",
        iso: "100"
      }
    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "違うユーザのフィルムを削除しようとしてできないか" do
    log_in_as(@user)
    assert_no_difference 'Film.count' do
      delete film_path(@other_user_film)
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
