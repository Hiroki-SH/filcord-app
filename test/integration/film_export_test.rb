require 'test_helper'

class FilmExportTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
    @film = films(:film1)
  end

  def request_film_export
    post film_export_path, params: {
      id: @film.id
    }
  end

  test "撮影データをCSVファイルでダウンロードできるか" do
    log_in_as(@user)
    request_film_export
    assert_match "text/csv", response.headers["Content-Type"]
    assert_match /attachment/, response.headers["Content-Disposition"]
  end

  test "撮影データのCSVファイルの内容が正しいか" do
    log_in_as(@user)
    request_film_export
    response.body.each_line.each_with_index do |line, idx|
      if idx == 0 
        assert_match "id,シャッタースピード,F値,撮影日", line
      else
        assert_match /^\d+,(1\/)?\d+,(\d+\.+)?\d+/, line
      end
    end
  end
end
