class AddGalleryIdToPaintings < ActiveRecord::Migration[5.2]
  def change
    add_column :paintings, :gallery_id, :integer
  end
end
