require 'test_helper'

class FilmsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:user1)
    @other_user = users(:user2)
    @film = films(:film1)
    @other_user_film = films(:film4)
  end

  test "filmの編集(edit)に失敗するテスト" do
    log_in_as(@user)
    get edit_film_path(@film)
    assert_template 'films/edit'
    patch film_path(@film), params: { 
      film: {
        name: "",
        iso: ""
      }  
    }
    assert_template 'films/edit'
  end

  test "filmの編集に成功するテスト" do
    #フレンドリーフォワーディングのテスト
    log_in_as(@user)
    get edit_film_path(@other_user_film)
    assert_redirected_to login_url
    log_in_as(@other_user)
    assert_redirected_to edit_film_path(@other_user_film)

    name = "FUJIFILM"
    iso = "200"
    patch film_path(@other_user_film), params: { 
      film: {
        name: name,
        iso: iso
      }  
    }
    assert_redirected_to user_url
    @other_user_film.reload
    assert_equal name, @other_user_film.name
    assert_equal iso, @other_user_film.iso
  end
end
