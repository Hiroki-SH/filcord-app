class AddIndexAndAddColumnToFilm < ActiveRecord::Migration[6.0]
  def change
    add_reference :films, :user, foreign_key: true
    add_index :films, [:user_id, :created_at]
  end
end
