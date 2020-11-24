class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :f_number
      t.string :shutter_speed
      t.references :film, foreign_key: true
      t.timestamps
    end
  end
end
