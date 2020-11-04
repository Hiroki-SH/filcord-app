class ChangeDataIsoToFilms < ActiveRecord::Migration[6.0]
  def change
    change_column :films, :iso, :string
  end
end
