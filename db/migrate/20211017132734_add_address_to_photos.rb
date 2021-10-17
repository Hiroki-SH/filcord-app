class AddAddressToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :address, :string
  end
end
