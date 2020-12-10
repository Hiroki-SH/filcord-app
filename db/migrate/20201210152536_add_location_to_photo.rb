class AddLocationToPhoto < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :lat, :string
    add_column :photos, :lng, :string
  end
end
