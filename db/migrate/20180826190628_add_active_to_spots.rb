class AddActiveToSpots < ActiveRecord::Migration[5.2]
  def change
    add_column :spots, :active, :boolean, default: true, null: false
  end
end
