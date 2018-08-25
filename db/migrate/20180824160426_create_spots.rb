class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.references :city, foreign_key: true
      t.string :address
      t.string :category
      t.string :name

      t.timestamps
    end
  end
end
