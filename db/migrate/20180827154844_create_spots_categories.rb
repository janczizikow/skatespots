class CreateSpotsCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :spots_categories do |t|
      t.references :spot, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
