class CreateSpotsPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :spots_photos do |t|
      t.references :user, foreign_key: true
      t.references :spot, foreign_key: true
      t.string :photo

      t.timestamps
    end
  end
end
