require 'test_helper'

class FilmsNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
  end

  test "filmの追加(new)に失敗するテスト" do
    log_in_as(@user)
    get new_film_path
    assert_template 'films/new'
    post films_path, params: {
      film: {
        name: "",
        iso: ""
      }
    }
    follow_redirect!
    assert_template 'films/new'
    assert_not flash.empty?
    assert_select 'div.error-explanation'

    get request.original_url #リロードできるか
    assert_template 'films/new'
  end

  test "filmの追加(new)に成功するテスト" do
    log_in_as(@user)
    get new_film_path
    assert_template 'films/new'

    name = "example film name"
    iso = "200"
    post films_path, params: {
      film: {
        name: name,
        iso: iso
      }
    }
    assert_not flash.empty?
    follow_redirect!
    assert_template 'users/show'
    assert_match name, response.body
  end
end
