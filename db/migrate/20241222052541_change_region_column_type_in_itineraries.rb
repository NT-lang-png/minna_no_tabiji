class ChangeRegionColumnTypeInItineraries < ActiveRecord::Migration[6.1]
  def change
    change_column :itineraries, :region, :integer, null: false, default: 0
  end

  def down
    change_column :itineraries, :region, :string
  end

end
