class CreateGallerys < ActiveRecord::Migration[5.2]
  def change
    create_table :gallerys do |t|
      t.string :name
    end
  end
end
