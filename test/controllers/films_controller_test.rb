require 'test_helper'

class FilmsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @film = films(:film1)
  end

  # test "indexアクションをgetできるか" do
  #   get films_path
  #   assert_response :success
  # end

  # test "newアクションをgetできるか" do
  #   get new_film_path
  #   assert_response :success
  # end

  test "ログインせずにフィルム詳細画面にリクエストしてリダイレクトされるか" do
    get film_path(@film)
    assert_redirected_to login_url
  end

  test "ログインせずに作成画面にリクエストしてリダイレクトされるか" do
    get new_film_path
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
    assert_redirected_to login_url
  end

  test "ログインせずに編集画面にリクエストしてリダイレクトされるか" do
    get edit_film_path(@film)
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
    assert_redirected_to login_url
  end


  test "ログインせずに削除しようとしてリダイレクトされるか" do
    assert_no_difference 'Film.count' do
      delete film_path(@film)
    end
    assert_redirected_to login_url
  end
end
