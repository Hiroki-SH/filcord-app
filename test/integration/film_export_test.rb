require 'test_helper'

class FilmExportTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
    @film = films(:film1)
  end

  test "撮影データのCSVファイルの内容が正しいか" do
    log_in_as(@user)
    post film_export_path, params: {
      id: @film.id
    }
    response.body.each_line.each_with_index do |line, idx|
      if idx == 0 
        assert_match "id,シャッタースピード,F値,撮影日", line
      else
        assert_match /^\d+,(1\/)?\d+,(\d+\.+)?\d+/, line
      end
    end
  end
end
