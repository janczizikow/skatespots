class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.references :city, foreign_key: true
      t.references :user, foreign_key: true
      t.string :address
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
