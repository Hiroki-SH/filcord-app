require 'test_helper'

class FilmsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:user1)
    @film = films(:film1)
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

  # test "filmの編集に成功するテスト" do
    
  # end
end
