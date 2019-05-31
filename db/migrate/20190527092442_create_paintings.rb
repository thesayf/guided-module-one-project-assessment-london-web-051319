class CreatePaintings < ActiveRecord::Migration[5.2]
  def change
    create_table :paintings do |t|
      t.string :title
      t.string :artist
      t.string :gallery
      t.integer :price
    end
  end
end
