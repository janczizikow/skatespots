class AddSlugToSpot < ActiveRecord::Migration[5.2]
  def change
    add_column :spots, :slug, :string
    add_index :spots, :slug
  end
end
