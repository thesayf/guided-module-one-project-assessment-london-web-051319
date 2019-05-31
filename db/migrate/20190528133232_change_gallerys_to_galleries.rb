class ChangeGallerysToGalleries < ActiveRecord::Migration[5.2]
  def change
    drop_table :gallerys
    create_table :galleries do |t|
      t.string :name
    end
  end
end
