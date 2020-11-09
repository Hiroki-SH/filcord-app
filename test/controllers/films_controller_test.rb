require 'test_helper'

class FilmsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "indexアクションをgetできるか" do
    get films_path
    assert_response :success
  end

  test "newアクションをgetできるか" do
    get new_film_path
    assert_response :success
  end
end
