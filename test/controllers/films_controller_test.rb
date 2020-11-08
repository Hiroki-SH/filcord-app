require 'test_helper'

class FilmsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "indexアクションをgetできるか" do
    get films_url
    assert_response :success
  end

  test "newアクションをgetできるか" do
    get new_film_url
    assert_response :success
  end

  # test "editアクションをgetできるか" do
  #   get edit_film_url
  #   assert_response :success
  # end

  # test "showアクションをgetできるか" do
  #   get film_url
  #   assert_response :success
  # end
end
