class AddCountryToSpots < ActiveRecord::Migration[5.2]
  def change
    add_column :spots, :country, :string
  end
end
